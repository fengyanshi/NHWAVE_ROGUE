         REAL,DIMENSION(:,:),ALLOCATABLE :: DEPTH
         INTEGER :: Mglob, Nglob, I, J
         REAL :: dep

         WRITE(*,*) 'Mglob ='
         READ(*,*) Mglob
         WRITE(*,*) 'Nglob ='
         READ(*,*) Nglob
         WRITE(*,*) 'depth ='
         READ(*,*) dep
         ALLOCATE (DEPTH(Mglob,Nglob))


         DO J=1,Nglob
         DO I=1,Mglob
           Depth(I,J)=dep 
         ENDDO
         ENDDO

         OPEN(1,FILE='depth.txt')
         DO J=1,Nglob
          WRITE(1,100)(Depth(I,J),I=1,Mglob)
         ENDDO
100      FORMAT(9000f12.6)

         END

