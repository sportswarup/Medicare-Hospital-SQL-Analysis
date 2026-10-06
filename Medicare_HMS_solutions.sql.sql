use MediCare_Hospital;
show tables;
describe Appointments;
#1.
select * from Patients;
#2.
select * from Doctors where salary > 100000 order by salary desc;
#3.
select doctor_id, doctor_name, salary, max(salary) as highest_salaries
from Doctors group by doctor_id, doctor_name, salary limit 10;
#4.
select count(*) as patient_count from Patients;
#5.
select avg(salary) as avg_salary from Doctors;
#6.
select D.department_name ,count(*) as departments_dr_count from Doctors d join Departments D 
on d.department_id = D.department_id
group by D.department_name;
#7.
select h.hospital_name, count(*) as dep_patient_count from Hospitals h join Patients p
on h.city = p.city
group by  h.hospital_name;
#8.
select * from Appointments where 
year(appointment_date) = year(curdate()) and 
month(appointment_date) = month(curdate());
#9.
select * from Appointments where status = 'Scheduled' order by appointment_date desc;
#10.
select * from Appointments where status = 'Completed' order by appointment_date desc;
#11.
select b.patient_id, p.patient_name, max(b.total_amount) as highest_spent from Bills b join Patients p 
on b.patient_id = p.patient_id
group by b.patient_id, p.patient_name 
order by max(b.total_amount) desc limit 10;
#12.
select h.hospital_name, p.city, sum(b.total_amount) as hosp_revenue from Hospitals h join Patients p
on h.city = p.city
left join Bills b on p.patient_id = b.patient_id
group by h.hospital_name, p.city;
#13.
select d.department_name, sum(b.total_amount) as dep_revenue from Departments d join Hospitals h
on d.hospital_id = h.hospital_id
join Patients p
on h.city = p.city
left join Bills b on p.patient_id = b.patient_id
group by d.department_name;
#14.
select m.medicine_name, max(quantity) as most_prescribed from Prescriptions p join Medicines m 
on p.medicine_id = m.medicine_id
group by m.medicine_name
order by max(quantity) desc;
#15.
select * from Patients p left join Appointments a
on p.patient_id = a.patient_id
where appointment_id is null;
#16.
select * from Doctors d where year(hire_date) > 2022 order by hire_date desc;
#17.
select date_format(bill_date, '%Y-%m') as month, count(bill_id) as total_bills,
	   sum(total_amount) as total_billing, avg(total_amount) as average_bill
from Bills
group by date_format(bill_date, '%Y-%m')
order by month;
#18.
select d.department_name, sum(total_amount) from Departments d join Hospitals h 
on d.hospital_id = h.hospital_id
join Patients p 
on h.city = p.city
join Bills b 
on p.patient_id = b.patient_id 
group by d.department_name
order by sum(total_amount) limit 1;
#19.
select *, rank() over(order by salary desc) as salary_ranking from Doctors;
#20.
select *, sum(total_amount) over(order by total_amount desc) as running_total from Bills;
#21.
select patient_name, count(*) as duplicate_counts from Patients group by patient_name having count(*) > 1;
#22.
select * from Patients where city = 'Mumbai';
#23.
select d.doctor_id, d.doctor_name, d.specialization, D.department_name from Doctors d join Departments D
on d.department_id = D.department_id
where d.department_id = 1;
#24.
select * from Bills where total_amount > 50000;
#25.
select avg(treatment_cost) as avg_treatment_cost from Treatments;
#26.
select p.treatment_id, p.medicine_id,m.medicine_name, sum(quantity) as most_usuage from Prescriptions p join Medicines m
on p.medicine_id = m.medicine_id
group by p.treatment_id, p.medicine_id,m.medicine_name
having sum(quantity) = 10
order by sum(quantity) desc;
#27.
select a.doctor_id, d.doctor_name from Appointments a left join Doctors d
on a.doctor_id = d.doctor_id
where d.doctor_id is null;
#28.
select * from Hospitals where city = 'Delhi';
#29.
select * from Patients where age > 60 order by age asc;
#30.
select a.doctor_id, d.doctor_name, count(*) as appointment_count
from Appointments a join Doctors d 
on a.doctor_id = d.doctor_id
group by a.doctor_id, d.doctor_name
order by count(*) desc;
#31.
select date_format(bill_date, '%Y-%m') as month, sum(total_amount) as monthly_revenue
from Bills
group by date_format(bill_date, '%Y-%m')
order by month;
#32.
select treatment_id, treatment_name, treatment_cost
from Treatments
where treatment_cost > (select avg(treatment_cost) from Treatments);
#33.
select p.patient_id, p.patient_name, a.appointment_date
from Patients p
join Appointments a
on p.patient_id = a.patient_id
where (a.patient_id, a.appointment_date) in (select patient_id, max(appointment_date) from Appointments group by patient_id);
#34.
select salary from 
(select distinct salary, dense_rank() over(order by salary desc) as salary_rank 
from Doctors) d
where salary_rank = 2;
#35.
create view patient_summary as
select p.patient_id, p.patient_name, 
	count(distinct a.appointment_id) as total_appointments,
    count(distinct b.bill_id) as total_bills,
    coalesce(sum(b.total_amount),0) as total_spent
from Patients p
left join Appointments a
on p.patient_id=a.patient_id
left join Bills b
on p.patient_id=b.patient_id
group by
    p.patient_id,
    p.patient_name;
#36.
delimiter //
create procedure get_bill_details
(in p_bill_id int)

begin

select * from Bills
where bill_id=p_bill_id;

end //
delimiter ;
#37.
create table bill_log
(
    log_id int auto_increment primary key,
    bill_id int,
    patient_id int,
    total_amount decimal(10,2),
    created_at timestamp default current_timestamp
);
delimiter //
#
create trigger trg_bill_insert

after insert on Bills
for each row

begin

insert into bill_log
(bill_id,
patient_id,
total_amount)

values
(new.bill_id,
new.patient_id,
new.total_amount);

end //
delimiter ;
#39.
with monthly_revenue as
(
select date_format(bill_date,'%Y-%m') as month, sum(total_amount) as revenue
from Bills
group by date_format(bill_date,'%Y-%m')
)

select * from monthly_revenue
order by month;
#40.
select hospital_name, revenue, dense_rank() over(order by revenue desc) as revenue_rank
from
(select hospital_name, sum(b.total_amount) as revenue
from Hospitals h
join Bills b
on h.hospital_id=b.hospital_id
group by h.hospital_id, h.hospital_name);
#41.
with medicine_count as
(
select d.department_name, m.medicine_name, 
count(*) as total_used, dense_rank() over( partition by d.department_id order by count(*) desc) as medicine_rank
from Prescriptions p
join Medicines m
on p.medicine_id=m.medicine_id
join Doctors doc
on p.doctor_id=doc.doctor_id
join Departments d
on doc.department_id=d.department_id
group by d.department_id, d.department_name, m.medicine_name
)

select department_name, medicine_name, total_used
from medicine_count
where medicine_rank=1;
#42.
select p.patient_id, p.patient_name, count(distinct a.doctor_id) as doctor_count
from Patients p
join Appointments a
on p.patient_id=a.patient_id
group by p.patient_id, p.patient_name
having count(distinct a.doctor_id)>1;
#43.
select doctor_id, doctor_name, total_appointments
from
(select d.doctor_id, d.doctor_name, count(a.appointment_id) as total_appointments,
dense_rank() over(order by count(a.appointment_id) desc) as doctor_rank
from Doctors d
left join Appointments a
on d.doctor_id=a.doctor_id
group by d.doctor_id, d.doctor_name
) 
where doctor_rank=1;
#44.
with yearly_revenue as
(select year(bill_date) as bill_year, sum(total_amount) as revenue
from Bills
group by year(bill_date)
)

select bill_year, revenue, lag(revenue) over(order by bill_year) as previous_year,
	   revenue-lag(revenue) over(order by bill_year) as revenue_growth
from yearly_revenue;
#45.
with monthly_revenue as
(
select
    date_format(bill_date,'%Y-%m') as month,
    sum(total_amount) as revenue
from Bills
group by date_format(bill_date,'%Y-%m')
)

select month, revenue, sum(revenue) over (order by month rows between 2 preceding and current row) as rolling_3_month_revenue
from monthly_revenue;
#46.
select p.patient_id, p.patient_name
from Patients p
left join Appointments a
on p.patient_id=a.patient_id
group by p.patient_id, p.patient_name
having max(a.appointment_date) <
date_sub(curdate(),interval 1 year)
or max(a.appointment_date) is null;
#47.
select d.doctor_id, d.doctor_name
from Doctors d
left join Appointments a
on d.doctor_id=a.doctor_id
group by d.doctor_id, d.doctor_name
having max(a.appointment_date) <
date_sub(curdate(),interval 1 year)
or max(a.appointment_date) is null;
#48.
select h.city, avg(b.total_amount) as average_bill
from Hospitals h
join Bills b
on h.hospital_id=b.hospital_id
group by h.city
order by average_bill desc;
#49.
select hospital_name, bill_id, total_amount
from
(select h.hospital_name, b.bill_id, b.total_amount,
dense_rank() over(partition by h.hospital_id order by b.total_amount desc) as bill_rank
from Hospitals h
join Bills b
on h.hospital_id=b.hospital_id
) 
where bill_rank=1;
#50.
select h.hospital_name,
    count(distinct p.patient_id) as total_patients,
    count(distinct d.doctor_id) as total_doctors,
    count(distinct a.appointment_id) as total_appointments,
    count(distinct b.bill_id) as total_bills,
    coalesce(sum(b.total_amount),0) as total_revenue,
    round(avg(b.total_amount),2) as average_bill
from Hospitals h
left join Doctors d
on h.hospital_id=d.hospital_id
left join Appointments a
on d.doctor_id=a.doctor_id
left join Patients p
on a.patient_id=p.patient_id
left join Bills b
on h.hospital_id=b.hospital_id
group by h.hospital_id, h.hospital_name
order by total_revenue desc;
