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
            using (var sqlConnection = new SqlConnection(Options.sqlConnection))
            {
                sqlConnection.Open();
                return sqlConnection.Query<DoctorDto>(StoredProcedures.GetAllDoctors, 
                    commandType: CommandType.StoredProcedure).ToList();
            }
        }
    }
}