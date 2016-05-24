!定义粒子的数据类型	
module type_define
	type::particle
		double precision::z                 !记录粒子坐标z
		double precision::r                 !记录粒子坐标r
		double precision::vz                !记录粒子x方向的速度vx
		double precision::vr                !记录粒子y方向的速度vy
		double precision::vtheta            !记录粒子z方向的速度vz
		double precision::weight
	end type particle
end module type_define


!全局常量和变量的定义
module constants
	use type_define
	implicit none

	!常量
	double precision,parameter::PI=3.141592653589793                                    !圆周率
	double precision,parameter::Masse=9.109382616d-31                                   !电子、离子1、离子2的质量
	double precision,parameter::Massion1=2.0*1.67262158d-27
	double precision,parameter::Massion2=3.0*1.67262158d-27   
	double precision,parameter::Qe=-1.6021765314d-19,Qi=1.6021765314d-19                !电子离子带电量
	double precision,parameter::Eps0=8.854187817d-12      
		
	!模型中用到的参数
	integer:: numbz                                                       !z-方向格点数目
	integer::NP                                                       !模拟的宏粒子个数
	double precision::lz                                          !lz/(numbz-1)
    double precision::dz                                       !lz极间距,dz格点间距 
     
	double precision::dt                                             !5.0d-12   ! 电子运动时间步长
	double precision,parameter::ns=1.0d-9                                              !1ns时间
	integer::nns                                                !1ns包含的时间步长数
    integer::step_max                                                !计算最大步数  

	double precision::n0                                             !电子密度
    double precision::v0                                                 !外加脉冲电源电压幅值v0（左侧边界电势）
    double precision::ue,uion1,uion2                                         !电子和离子的动能，单位是电子伏特eV

	double precision::weight                                         !粒子权重，根据上面各参量计算得到

    !控制参数
    integer::step_output                                                !输出间隔，单位ns
    integer::step_ave                                                 !对电势等求平均的时间步数,step_output应该是step_ave的整数倍	
	integer:: control_ion_time                                          !离子运动一个时间步长时间内电子运动的步数
	namelist /plasma/ numbz,NP,lz,dz,dt,step_max,n0,v0,ue,uion1,uion2,step_output,step_ave,control_ion_time
	
	
    !========================全局变量===============================================================================================
    integer::NP_e,NP_ion1,NP_ion2                           !实际粒子数，随时间变化
    integer::NPmax_e,NPmax_ion1,NPmax_ion2                  !最大粒子数
	type(particle),allocatable::electron(:),ion1(:),ion2(:)
	double precision,allocatable::potential(:)           !电场分布
	double precision,allocatable::field(:)
	double precision,allocatable::charge_density(:)      !电荷密度
	double precision,allocatable::e_density(:)           !电子的粒子数密度
	double precision,allocatable::ion1_density(:)        !离子1的粒子数密度
	double precision,allocatable::ion2_density(:)        !离子2的粒子数密度

    !相应平均值,用于output函数输出
	double precision,allocatable::potential_ave(:)           !电场分布
	double precision,allocatable::field_ave(:)
	double precision,allocatable::charge_density_ave(:)      !电荷密度
	double precision,allocatable::e_density_ave(:)           !电子的粒子数密度
	double precision,allocatable::ion1_density_ave(:)        !离子1的粒子数密度
	double precision,allocatable::ion2_density_ave(:)        !离子2的粒子数密度

end module constants
   				
