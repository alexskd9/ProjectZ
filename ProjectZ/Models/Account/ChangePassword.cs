using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace ProjectZ.Models.Account
{
    public class ChangePassword
    {
        [Required(ErrorMessage = "აუცილებელი ველია")]
        public string OldPassword { get; set; }

        [Required(ErrorMessage = "აუცილებელი ველია")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$", ErrorMessage = "პაროლში უნდა გამოიყენოთ მინიმუმ ერთი დიდი ასო, ერთი ციფრი და ერთი სიმბოლო; პაროლის მინიმალური სიგრძე - 8 სიმბოლო")]
        public string NewPassword { get; set; }

        [Required(ErrorMessage = "აუცილებელი ველია")]
        [Compare("NewPassword", ErrorMessage = "პაროლები არ ემთხვევა")]
        public string RepeatNewPassword { get; set; }
    }
}