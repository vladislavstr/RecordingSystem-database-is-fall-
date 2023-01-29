using RecordingSystem.DAL.Repositories;
using System;
using System.Globalization;

var d = new PatientRepository();
d.AddPatient("Muskat", "Str", "123-123", "@", null, true, "01-12-2012"); 


//var p = new DoctorRepository();
//var ppp = p.GetAllDoctors();
Console.WriteLine("qwe");