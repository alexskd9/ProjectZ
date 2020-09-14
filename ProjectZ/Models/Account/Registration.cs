using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ProjectZ.Models.Account
{
    public class Registration
    {
        [Required(ErrorMessage = "აუცილებელი ველია")]
        public string Name { get; set; }

        [Required(ErrorMessage = "აუცილებელი ველია")]
        public string Surname { get; set; }

        [Required(ErrorMessage = "აუცილებელი ველია")]
        [DataType(DataType.EmailAddress)]
        [EmailAddress(ErrorMessage = "უნდა ჰქონდეს ელ. ფოსტის ფორმატი")]
        public string Email { get; set; }

        [Required(ErrorMessage = "აუცილებელი ველია")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$", ErrorMessage = "პაროლში უნდა გამოიყენოთ მინიმუმ ერთი დიდი ასო, ერთი ციფრი და ერთი სიმბოლო; პაროლის მინიმალური სიგრძე - 8 სიმბოლო")]
        public string Password { get; set; }

        [Required(ErrorMessage = "აუცილებელი ველია")]
        [Compare("Password", ErrorMessage = "პაროლები არ ემთხვევა")]
        public string RepeatPassword { get; set; }

        public string City { get; set; }
        public string PostalCode { get; set; }
        public string Street { get; set; }
        public string Appartments { get; set; }
    }
}