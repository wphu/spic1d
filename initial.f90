!此文件包括粒子数、场和离子数组的分配，粒子位置和速度初始化，maxwell分布函数，将粒子向前推动半个时间步长以应用蛙跳法等子程序


!粒子数、场和离子数组的分配，粒子位置和速度初始化
subroutine initial_conditions( )
	use constants
	use type_define
	implicit none

	integer::i
	double precision::z
	double precision::vx,vy,vz
	real(8):: ran                             !随机数

	double precision::v_max,vm,vn,dv
	integer::k,kmax,fun_v(0:1000)

	NP_ion1=NP;NP_ion2=NP;NP_e=NP_ion1+NP_ion2
	NPmax_ion1=2*NP;NPmax_ion2=2*NP;NPmax_e=NPmax_ion1+NPmax_ion2
    allocate(electron(NPmax_e),ion1(NPmax_ion1),ion2(NPmax_ion2))
    allocate(potential(numbz))
    allocate(field(numbz))
    allocate(charge_density(numbz))
    allocate(e_density(numbz))
    allocate(ion1_density(numbz))
    allocate(ion2_density(numbz))

    allocate(potential_ave(numbz))
    allocate(field_ave(numbz))
    allocate(charge_density_ave(numbz))
    allocate(e_density_ave(numbz))
    allocate(ion1_density_ave(numbz))
    allocate(ion2_density_ave(numbz))

    potential=0.0
    field=0.0
    charge_density=0.0
    e_density=0.0
    ion1_density=0.0
    ion2_density=0.0

    potential_ave=0.0
    field_ave=0.0
    charge_density_ave=0.0
    e_density_ave=0.0
    ion1_density_ave=0.0
    ion2_density_ave=0.0

	do i=1,NP
		call maxwell(vx,vy,vz,ue,Masse)
		electron(i)%vz=vx
		electron(i)%vr=vy
		electron(i)%vtheta=vz
		call maxwell(vx,vy,vz,ue,Masse)
		electron(NP+i)%vz=vx
		electron(NP+i)%vr=vy
		electron(NP+i)%vtheta=vz

		call maxwell(vx,vy,vz,uion1,Massion1)
		ion1(i)%vz=vx
		ion1(i)%vr=vy
		ion1(i)%vtheta=vz
			
		call maxwell(vx,vy,vz,uion2,Massion2)
		ion2(i)%vz=vx
		ion2(i)%vr=vy
		ion2(i)%vtheta=vz

		call random_number(ran)
		z=lz*ran
		electron(i)%z=z
		electron(NP+i)%z=z
		ion1(i)%z=z
		ion2(i)%z=z
	end do

end subroutine initial_conditions

!麦克斯韦速度分布
subroutine maxwell(vx,vy,vz,kt,mass)                                          !kt是温度，单位eV;mass是粒子质量
	use constants
	implicit none
	double precision::vx,vy,vz,kt,mass,vt,v
	double precision::ran
	double precision::theta,phi

	vt=dsqrt(2.0*kt*Qi/mass)
	call random_number(ran)
	v=vt*dsqrt(-dlog(ran))

	call random_number(ran)
	theta=pi*ran
	call random_number(ran)
	phi=2.0*pi*ran

	vx=v*dsin(theta)*dcos(phi)
	vy=v*dsin(theta)*dsin(phi)
	vz=v*dcos(theta)
end subroutine maxwell


!统计粒子速度分布函数
!		if(0) then
!		open(150,file='fun_v.txt')
!		v_max=dsqrt(2.0*uion1*Qi/Massion1)
!		vm=-v_max;vn=v_max
!		kmax=1000
!		dv=v_max/kmax
!		fun_v=0.0
!		do i=1,NP_ion1
!			vz=ion1(i)%vz
!			write(*,*) vz
!			if(vz<0.0 .and. vz>vm) then
!			vz=-vz
!			k=vz/dv
	!		write(*,*) k
!			fun_v(k)=fun_v(k)+1
!
!			end if
!		end do 
!		do k=0,kmax
!			write(150,*) k*dv,fun_v(k)
!		end do
!
!		close(150)
!		end if
!		do i=NP+1,NP_e
!			call maxwell(vx,vy,vz,ue,Masse)
!			electron(i)%vx=vx
!			electron(i)%vy=vy
!			electron(i)%vz=vz
			
!			call random_number(ran)
!			z=lz*ran
!			electron(i)%z=z						
!		end do


!将位置向前推动半个时间步长，方便蛙跳法的使用
subroutine move_half(ptcl,numb)
	use constants
	use type_define
	implicit none
		
	integer::i
	integer::numb
	double precision::z,r,vz,vr

	type(particle)::ptcl(numb)

	do i=1,numb
		z=ptcl(i)%z
		vz=ptcl(i)%vz
		z=z+0.5*dt*vz

		if(z<0.0) then                                      !即如果粒子从下边界出去则从上边界进来，不在r方向损失（11.09）
			z=lz+z
		else if(z>lz) then
			z=z-lz
		end if

		ptcl(i)%z=z
	end do
end subroutine move_half
