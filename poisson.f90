
!!!!!!!!!!!!���ԽǾ���׷�Ϸ��Ⲵ�ɷ���
	subroutine poisson(v1)              !v1Ϊ�����ѹ�����Ǳ߽�����ʱ�õ�
		use constants
		implicit none

		integer::i,n
		double precision::v1
		double precision::ro(2:numbz-1)
		double precision::a(numbz-2),b(numbz-2),c(numbz-2),e(numbz-2),d(numbz-2),f(numbz-2),x(numbz-2)

		n=numbz-2
		do i=1,n-1
			f(i)=-(charge_density(i+1)*dz*dz)/Eps0
		end do
		f(n)=-(charge_density(n+1)*dz*dz)/Eps0-v1


		do i=1,n
			a(i)=1.0                                        !a(1)��c(numbz-2)Ӧ����0�����Ǽ����ò������������1Ҳ����
			b(i)=-2.0
			c(i)=1.0
		end do
		
		
!��ʽ��ʼ�ⷽ����
		call trid(a,b,c,f,x,n)
	
		do i=2,numbz-1
			potential(i)=x(i-1)
		end do
		potential(1)=0
		potential(numbz)=v1	

	end subroutine poisson
	
!!!!!!!!!!!!!!!���Խ�׷�Ϸ�	
	subroutine trid(a,b,c,f,x,n)             
		implicit none

		integer::i,n
		double precision::a(n),b(n),c(n),e(n),d(n),f(n),x(n)

		e(1)=c(1)/b(1)
		d(1)=f(1)/b(1)

		do i=2,n-1
			e(i)=c(i)/(b(i)-a(i)*e(i-1))
			d(i)=(f(i)-a(i)*d(i-1))/(b(i)-a(i)*e(i-1))
		end do
		d(n)=(f(n)-a(n)*d(n-1))/(b(n)-a(n)*e(n-1))	
		
		x(n)=d(n)
		do i=n-1,1,-1
			x(i)=d(i)-e(i)*x(i+1)
		end do

	end subroutine trid	