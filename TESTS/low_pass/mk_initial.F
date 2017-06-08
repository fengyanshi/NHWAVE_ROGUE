         parameter(m=1152,n=1024,l=5)
         real,dimension(m,n) :: var2D
         real,dimension(m,n,l) :: var3D
         real :: eta_left,eta_right,Temp,Sali,Usea
         integer :: i,j,nk

         eta_left = 0.0
         eta_right = 0.0
         Usea=-0.24

         do j=1,n
         do i=1,m
           var2D(i,j) = eta_left +(i-1.0)/(m-1.0)*(eta_right-eta_left)
         enddo
         enddo
         
! eta 

100      format(1000f12.3)

!         open(2,file='eta_init.ini')

!         do j=1,n
!          write(2,100)(var2D(i,j),i=1,m)
!         enddo
!         close(2)

         do k=1,l
         do j=1,n
         do i=1,m
           var3D(i,j,k)=Usea
         enddo
         enddo
         enddo

!     

         open(2,file='u_init.ini')

         do k=1,l
         do j=1,n
          write(2,100)(var3D(i,j,k),i=1,m)
         enddo
         enddo
         close(2)

         end




