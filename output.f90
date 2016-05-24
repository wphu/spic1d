!将结果输出到txt文件中，data文件夹下
subroutine output(step)
	use type_define
	use constants
	implicit none
		
	integer::step,i,fileid
    character(len=20)::filename,comment
    character(len=4)::time_out

    !计算电势等场量的平均值
    potential_ave=potential_ave+potential/step_ave
    field_ave=field_ave+field/step_ave
    charge_density_ave=charge_density_ave+charge_density/step_ave
    e_density_ave=e_density_ave+e_density/step_ave
    ion1_density_ave=ion1_density_ave+ion1_density/step_ave
    ion2_density_ave=ion2_density_ave+ion2_density/step_ave

    if(mod(step,step_output)==0) then
		    fileid=step/nns
		    write(time_out,'(i4.4)') fileid

            !====================================Output some plasma variables: potential, electric field.......=======================================
		    filename='data/'//trim(adjustl(time_out))//'ns.txt'
            comment='t='//trim(adjustl(time_out))//'ns'
		    open(fileid,file=filename)
		    write(fileid,'(7A15)') "z","potential","e_density","ion1_density","ion2_density","charge_density","field_z"
            write(fileid,'(7A15)') comment,comment,comment,comment,comment,comment,comment	
			do i=1,numbz
				!write(fileid,'(i5,6e14.4)') i,potential(i),e_density(i),ion1_density(i),ion2_density(i)&
				!	,charge_density(i),field(i)
				write(fileid,'(i5,6e14.4)') i,potential_ave(i),e_density_ave(i),ion1_density_ave(i),ion2_density_ave(i)&
					,charge_density_ave(i),field_ave(i)
			end do
		    close(fileid)
    end if

    if(mod(step,step_ave)==0) then
        potential_ave=0.0
        field_ave=0.0
        charge_density_ave=0.0
        e_density_ave=0.0
        ion1_density_ave=0.0
        ion2_density_ave=0.0   
    end if

end subroutine output
