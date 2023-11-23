//
//  SwiftUIView.swift
//  StickyNotesNC1
//
//  Created by Claudio Marciello on 16/11/23.
//

import SwiftUI
import SwiftData
struct CreateNoteView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @Query var Notes: [Note]
    @State var isOverlayVisible = false
    @State var currentNote: Note?
    @State var color: Color = .gray
    @State var text: String = ""
    @Binding var isActive: Bool
    @State var contained = false
    
    
 

    
    var body: some View {
        ZStack{
            Color(colorScheme == .light ? .white : Color(.systemGray6)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ZStack{
                
                
                GeometryReader{geometry in
                    
                    
                    ZStack(alignment: .center){
                        Color( colorScheme == .light ? Color(hexString: "F5F5F7"): .black ).ignoresSafeArea()
                        Rectangle()
                            .fill(Color(hexString: currentNote!.color))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .contrast(colorScheme == .dark ? 1.1 : 1)
                            .frame(width: 350, height: 350)
                            .padding(5)
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                        
                        
                        
                        TextField("", text: $text, prompt: Text("Enter your note...")
                            .font(.system(size: 24))
                            .foregroundColor(Color.gray)

                        )                            .contrast(colorScheme == .dark ? 1.1 : 1)

                           

                            .font(.system(size: currentNote!.font=="L" ? 24 : 12))
                            .foregroundStyle(.black)

                            .padding(.leading, 50)
                            .onDisappear {
                                currentNote!.name=text
                            }
                        
                    }
                    
                    
                }
                .onAppear{
                    
                    if currentNote?.name == "temporary"{
                        currentNote = Note(id: UUID(), name: "", date: Date(), color: "FFE691", font: "S", fontColor: "000000")}
                    text=currentNote!.name
                    isActive = false
                }
                .onDisappear{
                    for i in 0..<Notes.count{
                        if Notes[i].id == currentNote!.id{
                            self.contained = true
                        }
                    }
                    if contained == false{
                        context.insert(currentNote!)}
                }
                VStack {
                    Spacer()
                    ZStack{
                        
                        
                        HStack {
                            
                            Button(action: {
                                isOverlayVisible.toggle()
                            }) {
                                Image(systemName: "lightspectrum.horizontal")
                                    .symbolRenderingMode(.multicolor)
                                    .brightness(colorScheme == .dark ? 0.2 : 0)
                                    .contrast(colorScheme == .dark ?  1.1 : 1)
                                    .font(.title)
                            }
                            .accessibilityAddTraits([.isButton])
                            .padding()
                            .padding(.top,50)
                            .accessibilityLabel("Change Color")
                            
                            
                            Button(action: {
                                if currentNote!.font=="L"{
                                    currentNote?.font="S"
                                }
                                else{currentNote?.font="L"}})
                            {
                                    Image(systemName: "textformat")
                                    
                                        .contrast(colorScheme == .dark ?  1.1 : 1)
                                        .font(.title)
                                    
                                        .foregroundStyle(colorScheme == .dark ? .white : .black)
                                }.accessibilityLabel("Text size")
                                .accessibilityValue(                                    currentNote?.font=="S" ? "Small" : "Large")
                            
                                .padding(.top,50)
                            
                            
                            Spacer()
                            
                        }.padding(.bottom,-70)
                    }
                    .padding([.leading, .bottom])
                    
                }
            }                    .blur(radius: isOverlayVisible ? 10 : 0)
            
                .overlay(
                    Group {
                        if isOverlayVisible {
                            Color.black.opacity(0.1)
                                .frame(width: 500, height: 1000)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    // Handle tap on the overlay
                                    isOverlayVisible = false
                                }
                            
                            ScrollView{
                                VStack {
                                    HStack{
                                        
                                        Button(action: {
                                            isOverlayVisible = false
                                            
                                        }, label:{
                                            Image(systemName: "xmark")
                                                .font(.title3)
                                            
                                                .bold()
                                                .foregroundColor(colorScheme == .light ? .black : .white)
                                                .contrast(colorScheme == .dark ?  1.1 : 1)

                                        })
                                        Spacer()
                                        
                                        Text("Sticky Note")
                                            .font(.title3)

                                            .bold()
                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                            .contrast(colorScheme == .dark ?  1.1 : 1)

                                            .padding(.leading)
                                            .accessibilityHint("Select a Color")
                                        Spacer()
                                        Spacer().frame(width: 40)
                                    }
                                    
                                    
                                    HStack{
                                        Button(action:  {
                                            currentNote?.color = "FFE691"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Yellow")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "FFE691"))
                                                .foregroundStyle(Color(Color(hexString: "FFE691")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                        
                                        Button(action:  {
                                            currentNote?.color = "CFEBA8"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Green")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "CFEBA8"))
                                                .foregroundStyle(Color(Color(hexString: "CFEBA8")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        Button(action:  {
                                            currentNote?.color = "FFC2FF"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Light Pink")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "FFC2FF"))
                                                .foregroundStyle(Color(Color(hexString: "FFC2FF")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                    }
                                    
                                    HStack{
                                        
                                        Button(action:  {
                                            currentNote?.color = "F6C89A"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Orange")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "F6C89A"))
                                                .foregroundStyle(Color(Color(hexString: "F6C89A")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                        Button(action:  {
                                            currentNote?.color = "A1EEBE"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Mint")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "A1EEBE"))
                                                .foregroundStyle(Color(Color(hexString: "A1EEBE")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                        Button(action:  {
                                            currentNote?.color = "FFA9D8"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Pink")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "FFA9D8"))
                                                .foregroundStyle(Color(Color(hexString: "FFA9D8")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                    }
                                    
                                    HStack{
                                        
                                        Button(action:  {
                                            currentNote?.color = "F8B0A3"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Peach")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "F8B0A3"))
                                                .foregroundStyle(Color(Color(hexString: "F8B0A3")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                        Button(action:  {
                                            currentNote?.color = "98E8D9"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Cyan")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "98E8D9"))
                                                .foregroundStyle(Color(Color(hexString: "98E8D9")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        Button(action:  {
                                            currentNote?.color = "D7ADE7"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Purple")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "D7ADE7"))
                                                .foregroundStyle(Color(Color(hexString: "D7ADE7")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                    }
                                    HStack{
                                        Button(action:  {
                                            currentNote?.color = "FCA08D"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Apricot")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "FCA08D"))
                                                .foregroundStyle(Color(Color(hexString: "FCA08D")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                       
                                        Button(action:  {
                                            currentNote?.color = "A0D3F4"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("Light Blue")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "A0D3F4"))
                                                .foregroundStyle(Color(Color(hexString: "A0D3F4")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        
                                        
                                        Button(action:  {
                                            currentNote?.color = "FFFFFF"
                                            isOverlayVisible = false
                                            
                                        }, label: {Text("White")
                                                .padding()
                                                .frame(width: 100, height: 100)
                                                .background(Color(hexString: "FFFFFF"))
                                                .foregroundStyle(Color(Color(hexString: "FFFFFF")))
                                                .contrast(colorScheme == .dark ?  1.1 : 1)
                                                .cornerRadius(8)
                                            .shadow(radius: 1)})
                                        
                                        }}
                                
                            }
                            .padding()
                            .background(colorScheme == .light ? Color.white : Color(.systemGray6))
                            .cornerRadius(16)
                            .frame(width: 350, height: 500)
                            
                            
                        }
                        
                    }
                ).frame(height: 650)
            
        }}
    }



#Preview {
    CreateNoteView(currentNote: Note(id: UUID(), name: "", date: Date(), color: "FFE691", font: "S", fontColor: "000000"), isActive: .constant(false))
}
