import SwiftUI

struct LeaderBoardViewIphone14 : View {
    @Binding var showLeaderBoard: Bool
    @Binding var language: String
    var body: some View{
        GeometryReader{ geometry in
            Color.clear // Use a clear background here
            
            ZStack {
                Image((language == "English") ? "Leaderboard-Background" : "Leaderboard-Background-Viet")
                    .resizable()
                    .frame(width: 350, height: 520)
                    .cornerRadius(20)
                
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            showLeaderBoard = false
                        } label: {
                            Image("CloseButton")
                                .resizable()
                                .frame(width: 37, height: 37)
                        }.padding(.top, 178)
                            .padding(.trailing, 40)
                    }
                    List{
                        ForEach(1..<15){i in
                            ZStack{
                                HStack{
                                    Image("user1")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .padding(.trailing, 10)
                                    VStack(alignment: .leading){
                                        Text("BananaMilk").foregroundColor(.white)
                                            .font(.custom("Poppins-Bold", size: 15))
                                            .padding(.bottom, -10)
                                        Text("Super Gold Triumph")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Medium", size: 13))
                                            .padding(.bottom, 0)
                                        HStack{
                                            Text("67")
                                                .foregroundColor(.yellow)
                                                .font(.custom("Poppins-Bold", size: 14))
                                            Image("star")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .padding(.top, -5)
                                        }.padding(.top, -10)
                                    }.padding(.trailing, 36)
                                    Image("supergold")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }.padding(.leading, 30)
                                    .padding(.bottom, -10)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                        Rectangle()
                            .frame(width: 300, height: 450)
                            .padding(.bottom, 200)
                        )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct LeaderBoardViewIphone14ProMax : View {
    @Binding var showLeaderBoard: Bool
    @Binding var language: String
    
    var body: some View{
        GeometryReader{ geometry in
            Color.clear // Use a clear background here
            
            ZStack {
                Image((language == "English") ? "Leaderboard-Background" : "Leaderboard-Background-Viet")
                    .resizable()
                    .frame(width: 390, height: 580)
                    .cornerRadius(20)
                
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            showLeaderBoard = false
                        } label: {
                            Image("CloseButton")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }.padding(.top, 188)
                            .padding(.trailing, 45)
                    }
                    List{
                        ForEach(1..<15){i in
                            ZStack{
                                HStack{
                                    Image("user1")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding(.trailing, 10)
                                    VStack(alignment: .leading){
                                        Text("BananaMilk").foregroundColor(.white)
                                            .font(.custom("Poppins-Bold", size: 16))
                                            .padding(.bottom, -10)
                                        Text("Super Gold Triumph")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Medium", size: 14))
                                            .padding(.bottom, 0)
                                        HStack{
                                            Text("67")
                                                .foregroundColor(.yellow)
                                                .font(.custom("Poppins-Bold", size: 15))
                                            Image("star")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .padding(.top, -5)
                                        }.padding(.top, -10)
                                    }.padding(.trailing, 40)
                                    Image("supergold")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }.padding(.leading, 40)
                                    .padding(.bottom, -7)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                        Rectangle()
                            .frame(width: 400, height: 500)
                            .padding(.bottom, 200)
                        )
                        .padding(.top, 10)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct LeaderBoardViewIpad11 : View {
    @Binding var showLeaderBoard: Bool
    @Binding var language: String

    var body: some View{
        GeometryReader{ geometry in
            Color.clear // Use a clear background here
            
            ZStack {
                Image((language == "English") ? "Leaderboard-Background" : "Leaderboard-Background-Viet")
                    .resizable()
                    .frame(width: 650, height: 900)
                    .cornerRadius(20)
                
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            showLeaderBoard = false
                        } label: {
                            Image("CloseButton")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }.padding(.top, 166)
                            .padding(.trailing, 135)
                    }
                    List{
                        ForEach(1..<15){i in
                            ZStack{
                                HStack{
                                    Image("user1")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .padding(.trailing, 20)
                                    VStack(alignment: .leading){
                                        Text("BananaMilk").foregroundColor(.white)
                                            .font(.custom("Poppins-Bold", size: 28))
                                            .padding(.bottom, -15)
                                        Text("Super Gold Triumph")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Medium", size: 22))
                                            .padding(.bottom, 1)
                                        HStack{
                                            Text("67")
                                                .foregroundColor(.yellow)
                                                .font(.custom("Poppins-Bold", size: 26))
                                            Image("star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding(.top, -5)
                                        }.padding(.top, -5)
                                    }.padding(.trailing, 80)
                                    Image("supergold")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                }.padding(.leading, 140)
                                    .padding(.bottom, -7)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                        Rectangle()
                            .frame(width: 800, height: 750)
                            .padding(.bottom, 200)
                        )
                        .padding(.top, 15)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct LeaderBoardViewIpad12 : View {
    @Binding var showLeaderBoard: Bool
    @Binding var language: String

    var body: some View{
        GeometryReader{ geometry in
            Color.clear // Use a clear background here
            
            ZStack {
                Image((language == "English") ? "Leaderboard-Background" : "Leaderboard-Background-Viet")
                    .resizable()
                    .frame(width: 800, height: 1050)
                    .cornerRadius(20)
                
                VStack{
                    HStack{
                        Spacer()
                        Button{
                            showLeaderBoard = false
                        } label: {
                            Image("CloseButton")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }.padding(.top, 183)
                            .padding(.trailing, 145)
                    }
                    List{
                        ForEach(1..<15){i in
                            ZStack{
                                HStack{
                                    Image("user1")
                                        .resizable()
                                        .frame(width: 110, height: 110)
                                        .padding(.trailing, 30)
                                    VStack(alignment: .leading){
                                        Text("BananaMilk").foregroundColor(.white)
                                            .font(.custom("Poppins-Bold", size: 32))
                                            .padding(.bottom, -13)
                                        Text("Super Gold Triumph")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Medium", size: 26))
                                            .padding(.bottom, 3)
                                        HStack{
                                            Text("67")
                                                .foregroundColor(.yellow)
                                                .font(.custom("Poppins-Bold", size: 30))
                                            Image("star")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .padding(.top, -5)
                                        }.padding(.top, -5)
                                    }.padding(.trailing, 150)
                                    Image("supergold")
                                        .resizable()
                                        .frame(width: 110, height: 110)
                                }.padding(.leading, 160)
                                    .padding(.bottom, -2)
                            }.listRowBackground(Color.clear)
                        }
                    }.listStyle(PlainListStyle())
                        .mask(
                        Rectangle()
                            .frame(width: 850, height: 850)
                            .padding(.bottom, 200)
                        )
                        .padding(.top, 25)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
