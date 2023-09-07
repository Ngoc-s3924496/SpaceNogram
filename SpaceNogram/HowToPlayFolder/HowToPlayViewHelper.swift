/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Duong Vu Thanh Ngoc
 ID: s3924496 (e.g. 1234567)
 Created  date: 15/08/2023
 Last modified: 6/9/2023
 Acknowledgement: Flaticon.com, Minesweeper Genius
 */

import Foundation

func getStepInstructionE(step: Int) -> String{
    // Function to get the instruction based on the input step variable in English
    var returnString = ""
    if step == 1{
        returnString = "Your goal is to tap the tiles to create a path that connects the flag tiles"
    } else if step == 2{
        returnString = "The numbers on the side alarms indicate the numbers of bombs each row"
    } else if step == 3{
        returnString =  "The numbers on the top alarms indicate the numbers of bombs each column"
    } else if step == 4{
        returnString = "For instance: by reading the number 1 on top of the first column, we know there is 1 mine on it"
    } else if step == 5{
        returnString = "For instance: in this case, the only way to connect the two flags is through the upper right tile"
    } else if step == 6{
        returnString = "From level 3, there is a chance that a super bomb will appear that causes 2 damage"
    }
    return returnString
}

func getStepInstructionVN(step: Int) -> String{
    // Function to get the instruction based on the input step variable in Vietnamese
    var returnString = ""
    if step == 1{
        returnString = "Mục tiêu của bạn là chạm vào các ô để tạo ra một đường dẫn kết nối các ô có cờ"
    } else if step == 2{
        returnString = "Số trên các đèn cảnh báo bên cạnh cho biết số lượng bom trong mỗi hàng"
    } else if step == 3{
        returnString =  "Các số trên đèn cảnh báo phía trên cho biết số lượng bom trong mỗi cột"
    } else if step == 4{
        returnString = "Ví dụ: bằng cách đọc số 1 phía trên cột đầu tiên, chúng ta biết rằng có 1 quả mìn ở đó"
    } else if step == 5{
        returnString = "Ví dụ: trong trường hợp này, cách duy nhất để kết nối hai lá cờ là thông qua viên gạch ở phía trên bên phải"
    } else if step == 6{
        returnString = "Bắt đầu từ màn 3, sẽ có khả năng xuất hiện quả bom siêu cấp gây ra 2 sát thương"
    }
    return returnString
}
