!��һЩ������Ϣ�����/data/about.txt�ļ���
subroutine about()
	use type_define
	use constants
	implicit none

	double precision::debye,T,Ve_ave                      !�°ݳ��ȣ�������
	open(1,file='data/about.txt')
    	
	debye=sqrt(Eps0*ue/(n0*Qi))
	T=sqrt(Eps0*Masse/(n0*Qe*Qe))*2.0*pi
    Ve_ave=sqrt(2.0*ue*Qi/Masse)

    !������ļ�


	write(1,*) 'lz= ',lz
	write(1,*) 'dz= ',dz 
	write(1,*) 'dt= ',dt
	write(1,*) 'numbz=  ',numbz
	write(1,*) 'NP= ',NP
	write(1,*) 'weight= ',weight

	write(1,*) "�°ݳ���Ϊ��debye=    ",debye,"m"
	write(1,*) '������Ϊ��T=    ',T
	write(1,*) "����ƽ���ٶ�Ϊ��Ve_ave= ",Ve_ave,"m/s" 


    !�������Ļ
	write(*,*) 'lz= ',lz
	write(*,*) 'dz= ',dz 
	write(*,*) 'dt= ',dt
	write(*,*) 'numbz=  ',numbz
	write(*,*) 'NP= ',NP
	write(*,*) 'weight= ',weight

	write(*,*) "�°ݳ���Ϊ��debye=    ",debye,"m"
	write(*,*) '������Ϊ��T=    ',T
	write(*,*) "����ƽ���ٶ�Ϊ��Ve_ave= ",Ve_ave,"m/s"
    write(*,*) " "

    close(1)

end subroutine about