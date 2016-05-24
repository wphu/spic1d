!�������ӵ���������	
module type_define
	type::particle
		double precision::z                 !��¼��������z
		double precision::r                 !��¼��������r
		double precision::vz                !��¼����x������ٶ�vx
		double precision::vr                !��¼����y������ٶ�vy
		double precision::vtheta            !��¼����z������ٶ�vz
		double precision::weight
	end type particle
end module type_define


!ȫ�ֳ����ͱ����Ķ���
module constants
	use type_define
	implicit none

	!����
	double precision,parameter::PI=3.141592653589793                                    !Բ����
	double precision,parameter::Masse=9.109382616d-31                                   !���ӡ�����1������2������
	double precision,parameter::Massion1=2.0*1.67262158d-27
	double precision,parameter::Massion2=3.0*1.67262158d-27   
	double precision,parameter::Qe=-1.6021765314d-19,Qi=1.6021765314d-19                !�������Ӵ�����
	double precision,parameter::Eps0=8.854187817d-12      
		
	!ģ�����õ��Ĳ���
	integer:: numbz                                                       !z-��������Ŀ
	integer::NP                                                       !ģ��ĺ����Ӹ���
	double precision::lz                                          !lz/(numbz-1)
    double precision::dz                                       !lz�����,dz����� 
     
	double precision::dt                                             !5.0d-12   ! �����˶�ʱ�䲽��
	double precision,parameter::ns=1.0d-9                                              !1nsʱ��
	integer::nns                                                !1ns������ʱ�䲽����
    integer::step_max                                                !���������  

	double precision::n0                                             !�����ܶ�
    double precision::v0                                                 !��������Դ��ѹ��ֵv0�����߽���ƣ�
    double precision::ue,uion1,uion2                                         !���Ӻ����ӵĶ��ܣ���λ�ǵ��ӷ���eV

	double precision::weight                                         !����Ȩ�أ������������������õ�

    !���Ʋ���
    integer::step_output                                                !����������λns
    integer::step_ave                                                 !�Ե��Ƶ���ƽ����ʱ�䲽��,step_outputӦ����step_ave��������	
	integer:: control_ion_time                                          !�����˶�һ��ʱ�䲽��ʱ���ڵ����˶��Ĳ���
	namelist /plasma/ numbz,NP,lz,dz,dt,step_max,n0,v0,ue,uion1,uion2,step_output,step_ave,control_ion_time
	
	
    !========================ȫ�ֱ���===============================================================================================
    integer::NP_e,NP_ion1,NP_ion2                           !ʵ������������ʱ��仯
    integer::NPmax_e,NPmax_ion1,NPmax_ion2                  !���������
	type(particle),allocatable::electron(:),ion1(:),ion2(:)
	double precision,allocatable::potential(:)           !�糡�ֲ�
	double precision,allocatable::field(:)
	double precision,allocatable::charge_density(:)      !����ܶ�
	double precision,allocatable::e_density(:)           !���ӵ��������ܶ�
	double precision,allocatable::ion1_density(:)        !����1���������ܶ�
	double precision,allocatable::ion2_density(:)        !����2���������ܶ�

    !��Ӧƽ��ֵ,����output�������
	double precision,allocatable::potential_ave(:)           !�糡�ֲ�
	double precision,allocatable::field_ave(:)
	double precision,allocatable::charge_density_ave(:)      !����ܶ�
	double precision,allocatable::e_density_ave(:)           !���ӵ��������ܶ�
	double precision,allocatable::ion1_density_ave(:)        !����1���������ܶ�
	double precision,allocatable::ion2_density_ave(:)        !����2���������ܶ�

end module constants
   				
