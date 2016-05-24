!������
program main
	use type_define
	use constants
	implicit none
		
	integer::i=0,k=0
	integer::step=0                              !ģ���ʱ�䲽��
	double precision::time,dtt,vv                !���Ӻ����ӵ�ʱ�䲽����ͬ���õ�dtt���ռ�����ѹ�����Ǳ仯�ģ���vv��ʾ
	real::time_start,time_1ns,time_end           !�������еĿ�ʼ�ͽ���ʱ��

	call cpu_time(time_start)                    !��ȡ����ʼʱ��
	call random_seed()                           !������������ӣ�ʹÿ�����г���������������һ��
	call getparameter()							 !��data/inp.txt�ļ��ж����������
    call about()                                 !���ģ��Ļ�����Ϣ
					
    write(*,*) "��ʼ��ʼ��........."
	call initial_conditions( )

    !����ƶ��벽
	call move_half(electron,NP_e)
	call move_half(ion1,NP_ion1)
	call move_half(ion2,NP_ion2)

    !�������ӵ���㣬�������ܶȵ�
	call grid_PIC()

    write(*,*) "��ʼ��ѭ��........."
	do while(step<step_max)
		step=step+1
		k=k+1
		time=step*dt
		vv=v0

		call poisson(vv)                                                      !�ɵ���ܶȽⲴ�ɷ��̵õ���
		call solve_field()                                                    !�ɵ��Ʒֲ���糡

		call move_ptcl(electron,Qe,Masse,dt,NP_e)                             !�����ڵ糡���˶�
		if(k==control_ion_time) then
			k=0
			dtt=control_ion_time*dt                                            !���ӵ�ʱ�䲽���ǵ��ӵ�control_ion_time��
			call move_ptcl(ion1,Qi,Massion1,dtt,NP_ion1)                       !����1�ڵ糡���˶�
			call move_ptcl(ion2,Qi,Massion2,dtt,NP_ion2)                       !����2�ڵ糡���˶�
		end if

		call grid_PIC()			
		call output(step)
        if(mod(step,10*nns)==0) write(*,*) "time= ",step/nns," ns"

	end do
	write(*,*) "��ѭ������........."

	call cpu_time(time_end)                                   !��ȡ�������ʱ��
	write(*,*) "����������ʱ��: ",(time_end-time_start)/3600.0,"Сʱ"
	write(*,*) "total time: ",(time_end-time_start)," s"

end program main
