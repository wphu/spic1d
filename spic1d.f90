!主函数
program main
	use type_define
	use constants
	implicit none
		
	integer::i=0,k=0
	integer::step=0                              !模拟的时间步数
	double precision::time,dtt,vv                !电子和离子的时间步长不同，用到dtt；收集极电压可能是变化的，用vv表示
	real::time_start,time_1ns,time_end           !程序运行的开始和结束时间

	call cpu_time(time_start)                    !获取程序开始时间
	call random_seed()                           !产生随机数种子，使每次运行程序产生的随机数不一样
	call getparameter()							 !从data/inp.txt文件中读入输入参数
    call about()                                 !输出模拟的基本信息
					
    write(*,*) "开始初始化........."
	call initial_conditions( )

    !向后推动半步
	call move_half(electron,NP_e)
	call move_half(ion1,NP_ion1)
	call move_half(ion2,NP_ion2)

    !分配粒子到格点，计算电荷密度等
	call grid_PIC()

    write(*,*) "开始大循环........."
	do while(step<step_max)
		step=step+1
		k=k+1
		time=step*dt
		vv=v0

		call poisson(vv)                                                      !由电荷密度解泊松方程得电势
		call solve_field()                                                    !由电势分布求电场

		call move_ptcl(electron,Qe,Masse,dt,NP_e)                             !电子在电场下运动
		if(k==control_ion_time) then
			k=0
			dtt=control_ion_time*dt                                            !离子的时间步长是电子的control_ion_time倍
			call move_ptcl(ion1,Qi,Massion1,dtt,NP_ion1)                       !离子1在电场下运动
			call move_ptcl(ion2,Qi,Massion2,dtt,NP_ion2)                       !离子2在电场下运动
		end if

		call grid_PIC()			
		call output(step)
        if(mod(step,10*nns)==0) write(*,*) "time= ",step/nns," ns"

	end do
	write(*,*) "大循环结束........."

	call cpu_time(time_end)                                   !获取程序结束时间
	write(*,*) "程序运行用时间: ",(time_end-time_start)/3600.0,"小时"
	write(*,*) "total time: ",(time_end-time_start)," s"

end program main
