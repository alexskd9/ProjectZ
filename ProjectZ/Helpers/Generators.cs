using System;

namespace ProjectZ.Helpers
{
    public class Generators
    {
        //Key პაროლისთვის
        public static string Key = "148vbEnos@dsnc";

        //სურათია სახელის გენერირება
        public static string Random32()
        {
            return Guid.NewGuid().ToString("N");
        }

        //პაროლის ჰეშირება sha512-ის გამოყენებით
        public static string SHA512Hash(string input)
        {
            byte[] data = System.Security.Cryptography.SHA512.Create().ComputeHash(System.Text.Encoding.UTF8.GetBytes(input));
            string sha512 = "";
            for (int i = 0; i < data.Length; i++)
            {
                sha512 += data[i].ToString("x2");
            }
            return sha512;
        }
    }
}