!!!!!!!!!!!!!!!!!!�����и�㴦�ĵ���ܶ�!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

subroutine grid_PIC()
	use constants
	use type_define
	implicit none

	charge_density=0.0
	e_density=0.0
	ion1_density=0.0
	ion2_density=0.0

	call PIC(electron,e_density,Qe,NP_e)
	call PIC(ion1,ion1_density,Qi,NP_ion1)
	call PIC(ion2,ion2_density,Qi,NP_ion2)
	charge_density=e_density+ion1_density+ion2_density
	e_density=e_density/Qe
	ion1_density=ion1_density/Qi
	ion2_density=ion2_density/Qi

end subroutine grid_PIC
		


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!   ���������Ʒ�������
subroutine PIC(ptcl,density,qq,numb)             !qq���������������,numbΪ������     
	use constants
	use type_define
	implicit none
		
	integer::i,ipz
	integer::numb
	double precision::z,q_act,rd_z,rd1_z,qq     !q_act��ʾһ�����Ӵ����ʵ��������
	double precision::q(numbz),density(numbz)
	type(particle)::ptcl(numb)
		
	q=0.0
	do i=1,numb
		q_act=weight*qq
		z=ptcl(i)%z
		ipz=z/dz+1
		rd_z=z/dz+1-ipz
		rd1_z=1.0-rd_z
		q(ipz)=q(ipz)+q_act*rd1_z
		q(ipz+1)=q(ipz+1)+q_act*rd_z
	end do      

	do i=2,numbz-1
		density(i)=q(i)/(dz*dz*dz)              !!!!!!!!!!!!!!!!!!!!!��Ҫ����0.01��??????????????
	end do
	density(1)=q(1)/(0.5*dz*dz*dz)
	density(numbz)=q(numbz)/(0.5*dz*dz*dz)

end subroutine PIC


