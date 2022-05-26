---
title: Note for Learning WRFDA source code No.1
subtitle: 

# Summary for listings and search engines
summary: 学习WRFDA源码（一）

# Link this post with a project
projects: []

# Date published
date: "2021-10-22"

# Date updated
lastmod: "2021-10-22"

# Is this an unpublished draft?
draft: false

# Show this page in the Featured widget?
featured: false

# Featured image
# Place an image named `featured.jpg/png` in this page's folder and customize its options here.
image:
  caption: 'Image credit: [**Unsplash**](https://unsplash.com/photos/CpkOjOcXdUY)'
  focal_point: ""
  placement: 2
  preview_only: false

authors:
- admin

tags:
- Academic
- Data Assimilation
- Source Code

categories:
- Note
- 笔记
---

## 学习目的

通过学习WRFDA的源码，了解：

- 观测误差的读取与处理
- 质量控制的操作

## WRFDA源码结构

WRFDA源码位于WRF/var目录下，主要由以下几部分构成：

- build
- convertor
- da
- external
- gen_be
- gen_be_v3
- graphics
- obsproc
- run
- scripts
- test

对于观测的读入和写出处理由obsproc模块负责，本人实验中主要使用散射计（QuickStart Scattermeter）数据，首先预处理为Little_R格式数据后再由obsproc模块处理为WRFDA读入需要的.ascii格式数据。

接下来首先对这一部分代码进行学习。

WRF/var/obsproc文件夹下的内容主要包括：

- kmabufr_to_littler
- MAP_plot
- src
  - chech_obs.F90
  - constants.inc
  - error_hander.F90
  - fm_decoder.F90
  - Makefile
  - missing.inc
  - module_complete.F90
  - module_date.F90
  - module_decoded.F90
  - module_diagnostics.F90
  - module_duplicate.F90
  - module_err_afwa.F90
  - module_err_ncep.F90
  - module_func.F90
  - modue_gpspw_caa.F90
  - module_gpspw_gst.F90
  - module_gpspw.F90
  - module_cao.F90
  - module_inside.F90
  - module_intp.F90
  - module_map_utils.F90
  - module_map.F90
  - module_mm5.F90
  - module_namelist.F90
  - module_obs_merge.F90
  - module_per_type.F90
  - module_qc.F90
  - module_recoverh.F90
  - module_recoverp.F90
  - module_sort.F90
  - module_stntbl.F90
  - module_thin_ob.F90
  - module_type.F90
  - module_write.F90
  - obsproc.F90
  - platform_interface.inc
  - qc_reduction.F90
  - setup.F90
  - sort_platform.F90

其中主程序为obsproc.F90，其包含了所有的module代码完成主体功能，包括：

1. 读取编码的观测
2. 在气压值缺失时补全
3. 对观测按照位置和时间进行排序
4. 合并空间重复的站点（同样观测类型、同样位置、同样时间）
5. 剔除时间重合的站点（同样观测类型和位置，不同的时间）
6. 补全缺失高度值
7. 检查探针（垂直一致性和超绝热）
8. 移除namelist中top定义的高于MM5 lid的观测值
9. 估计观测误差
10. 写出输入到MM5的3D-VAR中

首先读取namelist.obsproc中的变量进行参数设置，对模拟的区域的参数进行设置，调用setup.F90函数，组要包括对坐标、投影方式、网格大小、网格数等基础参数进行设置。

```fortran
CALL setup (domain_check_h, iproj, phic, xlonc, truelat1, truelat2, &
#ifdef BKG
                   dis, xcntr, ycntr, xn, pole, psi1,  c2)
#else
                   maxnes, nestix, nestjx, dis, numc, nesti, nestj, &
                   ixc, jxc, xcntr, ycntr, xn, pole, psi1,  c2, &
                   xim11, xjm11)
```

接下来对一些需要用到的基本参数进行设置，然后调用read_obs_gts对Little_R观测文件的部分进行读取操作

```fortran
INQUIRE (FILE = obs_gts_filename, EXIST = exist )

      IF (exist .and. LEN(TRIM(obs_gts_filename))>0) THEN

         call read_msfc_table('msfc.tbl')

      !  Read data from input file

        CALL read_obs_gts (obs_gts_filename, obs, number_of_obs, &
          max_number_of_obs, fatal_if_exceed_max_obs, print_gts_read, &
          ins, jew, time_window_min, time_window_max,                 &
          map_projection, missing_flag)

      !  Reset unused memory for subsequent reading

        DO loop_index = number_of_obs+1, max_number_of_obs
           NULLIFY (obs (loop_index) % surface)
        ENDDO

      ELSE
         WRITE (0,'(/,A,/)') "No decoded observation file to read."
         STOP
      ENDIF
```

其中read_obs_gts定义在module_decoded.F90中，对于散射计数据，其FM码为281，由于散射计一般为海表面10米处风场，代码将高度小于0的设为10，高度的qc值设为0。

```fortran
IF ((obs (obs_num)%info%platform(1:6) .EQ. 'FM-281' ) .and. &
             (ASSOCIATED (obs (obs_num)%surface ) ) ) THEN
             if (obs(obs_num)%info%elevation .LT. 0.0) then
                 obs(obs_num)%surface%meas%height%data = 10.0
             else
                 obs(obs_num)%surface%meas%height%data = &
                 obs(obs_num)%info%elevation
             end if
             obs(obs_num)%surface%meas%height%qc = 0
          END IF
```

对于每个观测，调用read_measurements函数读取观测内容，该部分首先对坏值进行剔除，随后对于SMMI数据的误差进行了预定义：

```fortran
      !
      !  Assign the SSMI error (AFWA only)
      !

      ! initialize the variable that might be used in module_err_ncep.F90
      ! for checking if the error is pre-assigned
      current%meas%speed%error = 0.0

      READ (info % platform (4:6), '(I3)') fm

      IF ((fm .EQ. 125) .AND. (current%meas%speed%qc .GT. missing)) THEN 

      SELECT CASE (current%meas%speed%qc)

             CASE (0)
                 current%meas%speed%error = 2.  !m/s
             CASE (1)
                 current%meas%speed%error = 5.  !m/s
             CASE (2)
                 current%meas%speed%error = 10. !m/s
             CASE (3)
                 current%meas%speed%error = 20. !m/s
             CASE DEFAULT
                 current%meas%speed%error = 20. !m/s
      END SELECT

      current%meas%speed%qc = 0

      ELSE IF ((fm == 97 .or. fm == 96 .or. fm == 42) .and. &
               (current%meas%height%qc  == 0 ) ) then

               N_air = N_air + 1
               if (current%meas%height%data > aircraft_cut) then

! To convert the Aircraft observed height (> cutoff_height=3000m) to pressure:
! and discarded the observed height:
                  N_air_cut = N_air_cut + 1
             call Aircraft_pressure(current%meas%height, current%meas%pressure)
               endif

! Y.-R. Guo, 03/20/2008: In RTOBS 2006091300 data:obs.2006091300.gz, there are
!    two levels obs in FM-13 SHIP causing troubles in wrfvar.
! SHIP and BUOY, if pressure < 85000.0 Pa, discarded.
      ELSE IF ( fm == 13 .or. fm == 18 .or. fm == 19 ) THEN
           if (current%meas%pressure%data < 85000.0 .and. &
               current%meas%pressure%qc >= 0) then 
               write(0,'(a,3x,a,2x,a,2x,2f13.5,2x,"Pressure=",f10.1,a,i8)') &
                   'Discarded:', info%platform(1:12), trim(location%id), &
                   location%latitude,   location%longitude, &
                   current%meas%pressure%data, " < 85000.0 Pa, qc=", &
                   current%meas%pressure%qc 
              CYCLE read_meas
           endif

      ENDIF
```

这里对module_err_ncep.F90中fm=125的情况预定义了speed%error，那么散射计的误差能否这样预先定义好呢？于是我们转到module_err_ncep.F90进行查看，代码中对风速和风向的误差缺失进行了定义和插值

```fortran
3.  VERTICAL INTERPOLATION OF NCEP OBSERVATIONAL ERROR
! ======================================================

! 3.1 WIND DIRECTION FIXE TO 5 DEGREES
!     --------------------------------

      current % meas % direction % error = 5.

! 3.2 WIND SPEED
!     ----------

!     Some wind speed data are read with their errors, don't modify them

      IF (current % meas  % speed % error .LE. 0.) THEN
          current % meas % speed % error = intplin (pres, err_k (1:JPERR), &
                                                          err_u (1:JPERR))
      ENDIF

! 3.3 U-WIND COMPONENTS AS WIND SPEED
!     -------------------------------

      current % meas % u % error = intplin (pres, err_k (1:JPERR), &
                                                  err_u (1:JPERR))

! 3.4 V-WIND COMPONENT AS WIND SPEED
!     ------------------------------

      current % meas % v % error = intplin (pres, err_k (1:JPERR), &
                                                  err_v (1:JPERR))
```

可以发现，若预先定义direction%error以及speed%error（>=0）则自己定义的误差也就写入到了obsproc输出的内容中，这个过程可以直接写在module_err_ncep.F90直接对值进行定义。

### DA部分源码

#### 观测误差

在da部分源码中，对于ascii格式数据进行了读入，这里也就将观测的误差进行了读入，若需要对误差进行调整也可在该部分进行代码修改。

在da_read_obs_ascii.inc代码块中

```fortran
case (281)    ;
            if(.not.use_qscatobs  .or. ntotal(qscat) == max_qscat_input ) cycle reports
            if (n==1) ntotal(qscat) = ntotal(qscat) + 1
            if (outside) cycle reports
                if ( thin_conv_ascii ) then
                  crit = tdiff
                  call map2grids_conv(qscat,dlat_earth,dlon_earth,crit,nlocal(qscat),itx,1,itt,ilocal(qscat),iuse)
                   if ( .not. iuse ) cycle reports
                else
                   nlocal(qscat) = nlocal(qscat) + 1
                   ilocal(qscat) = ilocal(qscat) + 1
                end if

!            if (nlocal(qscat) == ilocal(qscat)) then

                if (.not. wind_sd_qscat) platform%each(1)%v%error = platform%each(1)%u%error

                iv%qscat(ilocal(qscat))%h = platform%each(1)%height
                iv%qscat(ilocal(qscat))%u = platform%each(1)%u
                iv%qscat(ilocal(qscat))%v = platform%each(1)%v

                if (wind_sd_qscat .and. &
                    platform%each(1)%u%qc /= missing_data .and. platform%each(1)%v%qc /= missing_data ) &
                    call da_ffdduv_model (iv%qscat(ilocal(qscat))%u%inv,iv%qscat(ilocal(qscat))%v%inv, &
                                          platform%each(1)%u%inv, platform%each(1)%v%inv, convert_uv2fd)

!            end if

            ! Impose minimum observation error = 1.0m/s for Quikscat data:
            iv%qscat(ilocal(qscat))%u%error = max(platform%each(1)%u%error,1.0)
            iv%qscat(ilocal(qscat))%v%error = max(platform%each(1)%v%error,1.0)
```

其中观测的误差由iv%qscat(ilocal(qscat))%u%error和iv%qscat(ilocal(qscat))%v%error存储，当wind_sd_qscat=true时，u%inv存储的speed，v%inv存储的是direction，对应的误差也由u%error和v%error存储。

#### 质量控制

质量控制在WRFDA中需要开启check_max_iv，对应到散射计的代码在da_check_max_iv_qscat.inc中，

一般对于观测的qc取0时，当直接对风速风向进行同化，则将会调用da_max_error_qc进行质量控制。

```fortran
subroutine da_max_error_qc (it, info, n, field, max_error,failed)

   !-----------------------------------------------------------------------
   ! Purpose: TBD
   !-----------------------------------------------------------------------

   implicit none

   integer,          intent(in)     :: it
   type(infa_type), intent(in)      :: info
   integer,           intent(in)    :: n
   type(field_type),  intent(inout) :: field
   real,              intent(in)    :: max_error
   logical,           intent(out)   :: failed

   real                               :: err, err_max
   integer                            :: qc_flag

   if (trace_use_frequent) call da_trace_entry("da_max_error_qc")

   failed = .false.

   qc_flag = field % qc
   err_max = field % error * max_error
   err     = field % inv
   err     = ABS (err)

   if (err > err_max) then
      field % qc = fails_error_max 
      failed = .true.
      field % inv = 0.0
   end if

   if (trace_use_frequent) call da_trace_exit("da_max_error_qc")

end subroutine da_max_error_qc
```

而da_check_max_iv_qscat在da_get_innov_vector_qscat.inc中进行了调用，其中输入的参数iv为o-b的结构体，故field%inv为o-b的值。

check_max_iv中对于$(o-b)^2>\alpha^2(\sigma^2_o+\sigma_b^2)$的观测直接进行了拒绝，这即是常规的质量控制方案。

若需要对质量控制进行修改，则应对da_max_error_qc代码进行修改。
