	
!根据电势求解电场
subroutine solve_field()
	use constants
	implicit none
	integer::i,j
		
	field(1)=-(-3.0*potential(1)+4.0*potential(2)-potential(3))/(2.0*dz)
	field(numbz)=-(potential(numbz-2)-4.0*potential(numbz-1)+3.0*potential(numbz))/(2.0*dz)	
	do i=2,numbz-1
		field(i)=-(potential(i+1)-potential(i-1))/(2.0*dz)
	end do
end subroutine solve_field

