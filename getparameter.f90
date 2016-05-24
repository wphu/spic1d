subroutine getparameter() 		
	use type_define
	use constants

	implicit none
	character(len=120) :: ifile

	open(3,file ='data/spic1d.inp')
	read(3,nml=plasma)
                    
    dz=lz/(numbz-1)
	
	nns=ns/dt
    step_max=step_max*nns

	weight=0.5*n0*lz*dz*dz/NP
	
    step_output=step_output*nns
    step_ave=step_ave*nns
		
end subroutine getparameter