using RecordingSystem.DAL.Models;
using Dapper;
using Microsoft.Data.SqlClient;
using System.Data;


namespace RecordingSystem.DAL
{
    public class DoctorRepository
    {
        public List<DoctorDto> GetAllDoctors()
        { 
            var sqlConnection = new SqlConnection(Options.sqlConnection);
            sqlConnection.Open();
            var result = sqlConnection.Query<DoctorDto>(StoredProcedures.GetAllDoctors, commandType: CommandType.StoredProcedure).ToList();
            sqlConnection.Close();
            return result;
        }
    }
}