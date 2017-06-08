1) use mk_depth.F to generate depth.txt
2) use mk_2dspcetrum.m to generate wave2d.txt
3) use mk_initial.f90 to generate u_init.ini, the hotstart file
4) write boundary file: boundary_flume.txt
5) in input.txt

! -----------------------------
! hot start, only provide U here, if you want to set V 
!     V_HotStart_File = v_init.ini
!     modify mk_initial.f90 to generate V
! in this sample, the flux is 1.20, and velocity splitting is 20/20/20/20/20
! so velocity at each layer should be 0.24m/s

   HOTSTART =T
   U_HotStart_File = u_init.ini

! -----------------------------
! periodic bc

   PERIODIC_X = F
   PERIODIC_Y = T

! -----------------------------
! boundary velocity, flux is 1.20 so velocity at each layer is 0.24m/s

   BOUNDARY = TID_FLX_LR
   BoundaryFile = boundary_flume.txt

! -----------------------------
!  wavemaker

   WAVEMAKER = INT_SPC
   Spc2D_File = wave2d.txt
   Xsource_West = 50.0
   Xsource_East = 53.0

! -----------------------------
!  sponge with low pass filtering 

   SPONGE_ON = T
   Sponge_West_Width =  30.0
   Sponge_East_Width =  30.0
   TID_LOW_PASS = T

