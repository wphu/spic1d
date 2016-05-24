!�ƶ������˶�
subroutine move_ptcl(ptcl,qq,mass,dtt,numb)
	use constants
	use type_define
	implicit none
		
	integer::i,j,ipz
	integer::numb
	double precision::z,vx,vy,vz,qq,mass,dtt
	double precision::az,Ez,rd_z,rd1_z
	type(particle)::ptcl(numb)

	j=0

	do i=1,numb
		z=ptcl(i)%z
		vx=ptcl(i)%vz
		vy=ptcl(i)%vr
		vz=ptcl(i)%vtheta

		ipz=z/dz+1
		rd_z=z/dz+1-ipz
		rd1_z=1.0-rd_z

		Ez=field(ipz)*rd1_z+field(ipz+1)*rd_z
		az=qq*Ez/mass
		z=z+(vz*dtt+az*dtt*dtt)
		vz=vz+az*dtt

!�ж����ӵ�λ���Ƿ񳬳��߽磬��������߽����Ϊ���Ӵ򵽼����ϣ�֮��Ͳ����˶�
		if(z>0.0 .and. z<lz) then
			j=j+1
			ptcl(j)%z=z
			ptcl(j)%vz=vx
			ptcl(j)%vr=vy
			ptcl(j)%vtheta=vz
		end if
	end do
	numb=j
end subroutine move_ptcl
