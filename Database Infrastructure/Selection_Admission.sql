SELECT e.Pid, e.Pname, e.PdayIn, e.Pdep, r.RmId FROM Ent_Patient e
LEFT JOIN Rel_AdmittedIn r
On e.Pid = r.Pid
