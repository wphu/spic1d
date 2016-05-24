!将一些基本信息输出到/data/about.txt文件中
subroutine about()
	use type_define
	use constants
	implicit none

	double precision::debye,T,Ve_ave                      !德拜长度，振荡周期
	open(1,file='data/about.txt')
    	
	debye=sqrt(Eps0*ue/(n0*Qi))
	T=sqrt(Eps0*Masse/(n0*Qe*Qe))*2.0*pi
    Ve_ave=sqrt(2.0*ue*Qi/Masse)

    !输出到文件


	write(1,*) 'lz= ',lz
	write(1,*) 'dz= ',dz 
	write(1,*) 'dt= ',dt
	write(1,*) 'numbz=  ',numbz
	write(1,*) 'NP= ',NP
	write(1,*) 'weight= ',weight

	write(1,*) "德拜长度为：debye=    ",debye,"m"
	write(1,*) '振荡周期为：T=    ',T
	write(1,*) "电子平均速度为：Ve_ave= ",Ve_ave,"m/s" 


    !输出到屏幕
	write(*,*) 'lz= ',lz
	write(*,*) 'dz= ',dz 
	write(*,*) 'dt= ',dt
	write(*,*) 'numbz=  ',numbz
	write(*,*) 'NP= ',NP
	write(*,*) 'weight= ',weight

	write(*,*) "德拜长度为：debye=    ",debye,"m"
	write(*,*) '振荡周期为：T=    ',T
	write(*,*) "电子平均速度为：Ve_ave= ",Ve_ave,"m/s"
    write(*,*) " "

    close(1)

end subroutine about