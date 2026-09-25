Use Hospital
--Q1
Select p.Name,w.Name
from Patients p Inner Join Wards w
on w.Id=p.WardId

--Q2
Select p.Name,d.DrugCode
from Patients p Inner Join DrugAdministrations d
on p.Id=d.PatientId

--Q3
select p.Name , c.Name
from Patients p Inner Join PatientExaminations pe
on p.Id=pe.PatientId
Inner Join Consultants c
on c.Id=pe.ConsultantId

--Q4
Select p.Name,w.Name
from Patients p left Join Wards w
on w.Id=p.WardId

--Q5
Select p.Name,w.Name
from Patients p right Join Wards w
on w.Id=p.WardId

--Q6
SELECT c.Name, p.Name
from Consultants c
left join PatientExaminations pe
on c.Id = pe.ConsultantId
left join Patients p
on p.Id = pe.PatientId

--Q7
Select p.Name,w.Name
from Patients p right Join Wards w
on w.Id=p.WardId

--Q8
Select c.Name, pc.PatientId
from Consultants c left join PatientConsultantAssignments pc
on c.Id=pc.ConsultantId

--Q9
Select p.Name,w.Name
from Patients p full Join Wards w
on w.Id=p.WardId

--Q10
Select c.Name, pc.PatientId
from Consultants c full join PatientConsultantAssignments pc
on c.Id=pc.ConsultantId

--Q11
Select n.Name,m.Name
from Nurses m Inner Join Nurses n
on m.Number=n.ManagerId

--Q12
Select n.Name,m.Name
from Nurses m Inner Join Nurses n
on m.Number=n.ManagerId

--Q13
Select n.Name,m.Name
from Nurses m Inner Join Nurses n
on m.Number=n.ManagerId

--Q14
Select p.Name,c.Name
from Patients p Cross Join Consultants c

--Q15
Select w.Name ,c.Name
from Wards w Cross Join Consultants c

--Q16
Select p.Name,w.Name,c.Name
from Patients p Inner Join Wards w
on w.Id=p.WardId
Inner Join  PatientExaminations pe
on p.Id=pe.PatientId
inner Join Consultants c
on c.Id=pe.ConsultantId

--Q17
Select p.Name, n.Name ,dr.Code
from Patients p Inner Join DrugAdministrations d
on p.Id=d.PatientId
Inner join Drugs dr
on dr.Code=d.DrugCode
inner join Nurses n	
on n.Number=d.NurseId

--Q18
Select p.Name PatientName,w.Name WardName , n.Name NurseName ,dr.Dosage DrugDosage
from Patients p Inner Join DrugAdministrations d
on p.Id=d.PatientId
Inner join Drugs dr
on dr.Code=d.DrugCode
inner join Nurses n	
on n.Number=d.NurseId
Inner join Wards w
on w.Id=p.WardId

--Q19
select p.Name PatientName,w.Name WardName ,c.Name ConsultantName
from Patients p Inner Join PatientExaminations pe
on p.Id=pe.PatientId
Inner Join Consultants c
on c.Id=pe.ConsultantId
Inner join Wards w
on w.Id=p.WardId

--Q20
Select p.Name PatientName,n.Name NurseName,dr.Code DrugCode,dr.Dosage DrugDosage ,d.DATE AdminDate,d.Time AdminTime
from Patients p Inner Join DrugAdministrations d
on p.Id=d.PatientId
Inner join Drugs dr
on dr.Code=d.DrugCode
inner join Nurses n	
on n.Number=d.NurseId

--Q21
Select c.Name ,c.Salary,ROW_NUMBER() Over(Order By salary Desc) RowNum
from Consultants c

--Q22
Select c.Name ,c.Salary,ROW_NUMBER() Over(Order By salary) RowNum
from Consultants c

--Q23
Select c.Name ,c.Salary,ROW_NUMBER() Over(Order By salary,Name) RowNum
from Consultants c

--Q24
Select c.Name ,c.Salary,RANK() Over(Order By salary Desc) RowNum
from Consultants c

--Q25
Select c.Name ,c.Salary,RANK() Over(Order By salary) RowNum
from Consultants c

--Q26
Select c.Name ,c.Salary,RANK() Over(Order By salary Desc) RowNum
from Consultants c
order by Salary Desc

--Q27
Select c.Name ,c.Salary,DENSE_RANK() Over(Order By salary Desc) RowNum
from Consultants c

--Q28
Select c.Name ,c.Salary,DENSE_RANK() Over(Order By salary Desc) RowNum
from Consultants c
order by Salary Desc

--Q29
Select c.Name ,c.Salary,DENSE_RANK() Over(Order By salary Desc) DenseRank,RANK() over (Order by salary desc) Rank
from Consultants c

--Q30
Select c.Name ,c.Salary,NTILE(2) Over(Order By salary Desc) RowNum
from Consultants c

--Q31
Select c.Name ,c.Salary,NTILE(3) Over(Order By salary) RowNum
from Consultants c

--Q32
Select c.Name ,c.Salary,NTILE(4) Over(Order By salary Desc) RowNum
from Consultants c

ALTER TABLE Nurses
ADD Salary DECIMAL(10,2);

--Q33
select Name,ServesInWardId,Salary,RANK() Over (PARTITION BY ServesInWardIdORDER order by Salary DESC) AS SalaryRank
from Nurses
order by ServesInWardId, Salary DESC;

--Q34
select Name,ServesInWardId,Salary,ROW_NUMBER() Over (PARTITION BY ServesInWardIdORDER order by Salary DESC) AS SalaryRank
from Nurses
order by ServesInWardId, Salary DESC;

--Q35
select Name,ServesInWardId,Salary,DENSE_RANK() Over (PARTITION BY ServesInWardIdORDER order by Salary DESC) AS SalaryRank
from Nurses
order by ServesInWardId, Salary DESC;

--Q36
Select Name,Salary ,NTILE(2) Over (Order by Salary desc)
From Nurses

-- Q37
Select n.Name,w.Name,n.Salary,
       RANK() Over(
           Partition By n.ServesInWardId
           Order By n.Salary Desc
       ) SalaryRank
from Nurses n
Join Wards w
on w.Id=n.ServesInWardId;


-- Q38
Select p.Name,w.Name,c.Salary,
       RANK() Over(
           Order By c.Salary Desc
       ) ConsultantRank
from Patients p
inner Join Wards w
on w.Id=p.WardId
inner Join PatientExaminations pe
on pe.PatientId=p.Id
inner Join Consultants c
on c.Id=pe.ConsultantId;


-- Q39
Select p.Name,n.Name,da.Dosage,n.Salary,
       RANK() Over(
           Partition By n.ServesInWardId
           Order By n.Salary Desc
       ) NurseRank
from Patients p
inner Join DrugAdministrations da
on da.PatientId=p.Id
inner Join Nurses n
on n.Number=da.NurseId;