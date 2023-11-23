//
//  ContentView.swift

import SwiftData
import SwiftUI

struct TruncatedText: View {
    let text: String
    let maxLength: Int

    var body: some View {
        if text.count > maxLength {
            //let truncatedText = String(text.prefix(maxLength / 2)) + "..." + String(text.suffix(maxLength / 2))
            let truncatedText = String(text.prefix(maxLength)) + "..."
            return Text(truncatedText)
        } else {
            return Text(text)
        }
    }
}

struct NoteRow1: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @Query(sort: \Note.date) var Notes: [Note]
    let numberOfRectangles: Int
    @Binding var isDragged: Bool
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    
    var body: some View {
        
        HStack {
            ForEach(0..<numberOfRectangles, id:\.self) { i in
                var formattedDate: String {
                    return dateFormatter.string(from: Notes[i].date)
                }
                NavigationStack{
                    VStack{
                        NavigationLink(destination: CreateNoteView(currentNote: Notes[i], isActive: .constant(false)).disabled(isDragged), label: {
                            ZStack(alignment: .leading){
                                
                                Rectangle()
                                    .fill(Color(hexString: Notes[i].color))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .frame(width: 110, height: 110)
                                    .padding(5)
                                
                                
                                TruncatedText(text: Notes[i].name, maxLength: Notes[i].font=="L" ? 7 : 14)
                                    .padding(10)
                                    .lineLimit(1) // Ensure that the text stays on a single line
                                    .minimumScaleFactor(0.5) // Adjust as needed
                                    .font(.system(size: Notes[i].font=="L" ? 24 : 12))                             .foregroundStyle(Color(hexString: Notes[i].fontColor))
                                    
                                
                                Text(formattedDate)
                                    .font(.caption)
                                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)                                    .padding(.top, 130)
                                    .padding(.leading, 20)
                                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            }
                                
                            
                        }).accessibilityAddTraits([.isLink])
                            .accessibilityRemoveTraits([.isButton])

                            .accessibilityLabel(Notes[i].name.isEmpty ? "Empty Note" : "Note")
                            .accessibilityValue(Notes[i].name.isEmpty ? "" : Notes[i].name)
                            
                        
                        
                    }
                    .draggable(Notes[i].id.uuidString)
                    {ZStack{
                        
                        Rectangle()
                            .fill(Color(hexString: Notes[i].color))
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: 110, height: 110)
                            .padding(5)
                        
                        
                        
                        TruncatedText(text: Notes[i].name, maxLength: 15)
                            .padding()
                            .lineLimit(1) // Ensure that the text stays on a single line
                            .minimumScaleFactor(0.5) // Adjust as needed
                            .font(.custom(Notes[i].font, size: 12))
                            .foregroundStyle(Color(hexString: Notes[i].fontColor))
                        
                        Text(formattedDate)
                            .font(.caption)
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)                                    .padding(.top, 130)
                    }
                    .onAppear{isDragged=true}
                                        
                    }
                }

                }
            }.padding(.vertical, -150)
        }
    }



struct NoteRow2: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var dragOffset: CGSize = .zero
    @State private var drags: [Int: CGSize] = [0:CGSize.zero, 1:CGSize.zero, 2:CGSize.zero]
    @Environment(\.modelContext) var context
    @Query(sort: \Note.date) var Notes: [Note]
    
    let numberOfRectangles: Int
    @Binding var isDragged: Bool
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var body: some View {
        
        HStack {
            ForEach(3..<numberOfRectangles+3, id:\.self) { i in
                var formattedDate: String {
                    return dateFormatter.string(from: Notes[i].date)
                }
                NavigationStack{
                    VStack{
                        NavigationLink(destination: CreateNoteView(currentNote: Notes[i], isActive: .constant(false)).disabled(isDragged), label: {
                            ZStack{
                                
                                Rectangle()
                                    .fill(Color(hexString: Notes[i].color))

                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .frame(width: 110, height: 110)
                                    .padding(5)
                                
                                
                                TruncatedText(text: Notes[i].name, maxLength: Notes[i].font=="L" ? 7 : 14)
                                    .padding()
                                    .lineLimit(1) // Ensure that the text stays on a single line
                                    .minimumScaleFactor(0.5) // Adjust as needed
                                    .font(.system(size: Notes[i].font=="L" ? 24 : 12))                             .foregroundStyle(Color(hexString: Notes[i].fontColor))
                                
                                Text(formattedDate)
                                    .font(.caption)
                                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)                                    .padding(.top, 130)
                            }
                            
                        }).accessibilityAddTraits([.isLink])
                            .accessibilityRemoveTraits([.isButton])

                            .accessibilityLabel(Notes[i].name.isEmpty ? "Empty Note" : "Note")
                            .accessibilityValue(Notes[i].name.isEmpty ? "" : Notes[i].name)

                        
                    }
                    .draggable(Notes[i].id.uuidString)
                    {ZStack{
                        Rectangle()
                            .fill(Color(hexString: Notes[i].color))

                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: 110, height: 110)
                            .padding(5)
                        
                        
                        
                        TruncatedText(text: Notes[i].name, maxLength: 15)
                            .padding()
                            .lineLimit(1) // Ensure that the text stays on a single line
                            .minimumScaleFactor(0.5) // Adjust as needed
                            .font(.custom(Notes[i].font, size: 12))
                            .foregroundStyle(Color(hexString: Notes[i].fontColor))
                        
                        Text(formattedDate)
                            .font(.caption)
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)                                    .padding(.top, 130)
                    }
                    
                                        .onAppear{isDragged=true}

                                                        }
                
                            
                    }



                }
            }.padding(.vertical, -150)
                
        }
    }


struct NoteRow3: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var dragOffset: CGSize = .zero
    @State private var drags: [Int: CGSize] = [0:CGSize.zero, 1:CGSize.zero, 2:CGSize.zero]
    @Environment(\.modelContext) var context
    @Query(sort: \Note.date) var Notes: [Note]
    
    let numberOfRectangles: Int
    @Binding var isDragged: Bool
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    var body: some View {
        
        HStack {
            ForEach(6..<numberOfRectangles+6, id:\.self) { i in
                var formattedDate: String {
                    return dateFormatter.string(from: Notes[i].date)
                }
                NavigationStack{
                    VStack{
                        NavigationLink(destination: CreateNoteView(currentNote: Notes[i], isActive: .constant(false)).disabled(isDragged), label: {
                            ZStack{
                                
                                Rectangle()
                                    .fill(Color(hexString: Notes[i].color))

                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .frame(width: 110, height: 110)
                                    .padding(5)
                              
                                    
                                
                                
                                TruncatedText(text: Notes[i].name, maxLength: Notes[i].font=="L" ? 7 : 14)
                                    .padding()
                                    .lineLimit(1) // Ensure that the text stays on a single line
                                    .minimumScaleFactor(0.5) // Adjust as needed
                                    .font(.system(size: Notes[i].font=="L" ? 24 : 12))                             .foregroundStyle(Color(hexString: Notes[i].fontColor))
                                
                                Text(formattedDate)
                                    .font(.caption)
                                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)                                    .padding(.top, 130)
                            }
                            

                            
                        }).accessibilityAddTraits([.isLink])
                            .accessibilityRemoveTraits([.isButton])
                            .accessibilityLabel(Notes[i].name.isEmpty ? "Empty Note" : "Note")
                            .accessibilityValue(Notes[i].name.isEmpty ? "" : Notes[i].name)


                    }
                    .draggable(Notes[i].id.uuidString)
                    {ZStack{
                        
                        Rectangle()
                            .fill(Color(hexString: Notes[i].color))

                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .frame(width: 110, height: 110)
                            .padding(5)
                        
                        
                        
                        TruncatedText(text: Notes[i].name, maxLength: 15)
                            .padding()
                            .lineLimit(1) // Ensure that the text stays on a single line
                            .minimumScaleFactor(0.5) // Adjust as needed
                            .font(.custom(Notes[i].font, size: 12))
                            .foregroundStyle(Color(hexString: Notes[i].fontColor))
                        
                        Text(formattedDate)
                            .font(.caption)
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)                                    .padding(.top, 130)
                    }
                        
                    .onAppear{isDragged=true}
                        
                    }
                    
                    
                    
                    
                }
                }
            }.padding(.vertical, -150)
        }
    }




struct DeleteButton: View{
    @Environment(\.colorScheme) var colorScheme

    @Environment(\.modelContext) var context
    @Query(sort: \Note.date) var Notes: [Note]
    @Binding var isTargeted: Bool
    @State var hover: Bool = false
    var body: some View {


            ZStack{
                
                Circle()
                    .foregroundColor(Color.white)
                    .scaledToFit()
                    .frame(width: 50, alignment: .center)
                    .onAppear{
                    }
                
                Image(systemName: "trash.circle")
                    .resizable()
                    .foregroundStyle(isTargeted ? Color.red : (colorScheme == .light ? Color.black : Color.white))
                    .background(colorScheme == .dark ? .black : .white)
                    .frame(width: isTargeted ? 70 : 50, height: isTargeted ? 70 : 50)
                    .animation(.smooth)
                    
                
                
                
            }
        
        }
    }




struct PlusButton: View{
    @Environment(\.colorScheme) var colorScheme

    @Environment(\.modelContext) var context
    @Query(sort: \Note.date) var Notes: [Note]
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(colorScheme == .light ? Color(red: 156/255, green: 220/255, blue: 58/255) : Color(red: 216/255, green: 255/255, blue: 1/255))
                .scaledToFit()
                .frame(width: 50, alignment: .center)
    
            Rectangle()
                .foregroundColor(colorScheme == .light ? Color(red: 56/255, green: 156/255, blue: 4/255) : Color(red: 125/255, green: 143/255, blue: 17/255) )
                .frame(width: 6.5, height: 30, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(0.5)
                
            Rectangle()
                .foregroundColor(colorScheme == .light ? Color(red: 56/255, green: 156/255, blue: 4/255) : Color(red: 125/255, green: 143/255, blue: 17/255) )
                .frame(width: 30, height: 6.5, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(0.5)
            
            Rectangle().foregroundStyle(.black)
                .frame(width: 6.5, height: 6.5)
                .opacity(colorScheme == .light ? 0.1 : 1)
                
        }.accessibilityAddTraits([.isLink])
            .accessibilityRemoveTraits([.isButton])
            .accessibilityLabel("Plus")
        .onTapGesture {

            isActive=true


        }  .disabled(Notes.count>8)
    }
}




    struct MainView: View {
        @Environment(\.colorScheme) var colorScheme

        @State private var numberOfRectangles = 0
        let rectanglesPerHStack = 3
        @Environment(\.modelContext) var context
        @State private var isShowingSheet = false
        @Query(sort: \Note.date) var Notes: [Note]
        @State var isDragged: Bool = false
        @State var isActive: Bool = false

        @State var isTargeted: Bool = false
        
        
        
        
        static func reloadSampleData(modelContext: ModelContext) {
            do {
                try modelContext.delete(model: Note.self)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        
        
        var body: some View {
            @State var size: CGSize = .zero
            NavigationStack{
                NavigationLink(destination: CreateNoteView(currentNote: Note(id: UUID(), name: "temporary", date: Date(), color: "000000", font: "S", fontColor: "000000"), isActive: $isActive), isActive: $isActive){}.isDetailLink(false)
                    .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                GeometryReader{ geometry in
                    ZStack{
                        VStack{
                            HStack{
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    
                                    Image(systemName: "lock")
                                        .resizable()
                                        .frame(width: 25, height: 30)
                                        .foregroundStyle(.orange)
                                        .brightness(colorScheme == .dark ? 0.2 : 0)
                                        .saturation(2)
                                        .padding(10)
                                    .fontWeight(.light)})
                                
                                
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.purple)
                                        .brightness(colorScheme == .dark ? 0.2 : 0)
                                        .saturation(2)
                                        .padding(10)
                                        .fontWeight(.light)
                                    .accessibilityLabel("Help")})
                                
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    
                                    Image(systemName: "ellipsis.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.blue)
                                        .brightness(colorScheme == .dark ? 0.2 : 0)
                                        .saturation(2)
                                        .padding(10)
                                        .fontWeight(.light)
                                    .accessibilityLabel("Options")})
                                
                            }
                            
                            ZStack{
                                
                                Rectangle()
                                    .fill(colorScheme == .light ? Color(red: 156/255, green: 220/255, blue: 58/255) :  Color(red: 216/255, green: 255/255, blue: 1/255))
                                    .frame(height: 50)
                                HStack{
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundStyle(.black)
                                        .padding(.leading, 10)
                                        .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                    
                                    VStack
                                    {Text("Sticky Notes Unlimited")
                                            .font(.title3)
                                            .foregroundStyle(.black)
                                            .padding(.trailing, 35)
                                            .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                        
                                        Text("Unlock all pro features.").font(.caption)
                                            .foregroundStyle(.black)
                                            .fontWeight(.light)
                                            .padding(.trailing, 110)
                                        .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)}
                                    
                                    
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .bold()
                                        .foregroundStyle(.black)
                                    
                                    
                                    Spacer().frame(width: 30)
                                        .accessibilityHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                }
                                .accessibilityAddTraits([.isLink])                                .accessibilityRemoveTraits([.isImage])
                                .accessibilityLabel("Sticky Notes Unlimited Subscription")
                                .accessibilityHint("Subscribe to unlock all pro features.")
                            }
                            VStack{
                                /*Rectangle()
                                 .fill(LinearGradient(
                                 gradient: Gradient(colors: [Color.purple, Color.yellow]),
                                 startPoint: .bottomLeading,
                                 endPoint: .topTrailing
                                 )
                                 )
                                 .frame(width: geometry.size.width-10, height: 100)
                                 .clipShape(RoundedRectangle(cornerRadius: 10))*/
                                ZStack{
                                    NoteRow1( numberOfRectangles: min(Notes.count, rectanglesPerHStack), isDragged: $isDragged).position(CGPoint(x: geometry.size.width/2, y: geometry.size.height/2-200))
                                    NoteRow2(numberOfRectangles: max(0, min(Notes.count - rectanglesPerHStack, rectanglesPerHStack)), isDragged: $isDragged).position(CGPoint(x: geometry.size.width/2, y: geometry.size.height/2-50)).accessibilityElement(children: .contain).disabled(Notes.count<4)
                                    NoteRow3(numberOfRectangles: max(0, Notes.count - (2 * rectanglesPerHStack)), isDragged: $isDragged).position(CGPoint(x: geometry.size.width/2, y: geometry.size.height/2+100)).accessibilityElement(children: .contain)
                                }
                                .padding(.top,-50)
                                
                            }.dropDestination(for: String.self){_, _ in
                                isDragged=false
                                    return true
                            }
                        }
                        .dropDestination(for: String.self){_, _ in
                                isDragged=false
                                    return true
                            }
                        HStack{
                            if isDragged == true{
                                DeleteButton(isTargeted: $isTargeted)
                                    .position(CGPoint(x: geometry.size.width/2, y: geometry.size.height-50))
                                    .dropDestination(for: String.self){dropped,location  in
                                        for i in 0...Notes.count-1{
                                            if Notes[i].id.uuidString == dropped[0]{
                                                context.delete(Notes[i])
                                            }
                                        }
                                        isDragged=false
                                        return true
                                        
                                    }isTargeted: { value in
                                        isTargeted = true
                                    }.onDisappear{isTargeted=false}
                            }
                            else{
                                
                                PlusButton(isActive: $isActive)
                                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                                    .position(CGPoint(x: geometry.size.width/2, y: geometry.size.height-50))
                                    
                                }}
                        
                        /*Button("Delete all"){
                            MainView.reloadSampleData(modelContext: context)
                        }.position(CGPoint(x: 300.0, y: 660.0))*/
                        
                    }
                }
                
            }
            .accentColor(colorScheme == .light ? .black : .white)

            }
    }


#Preview {MainView()}
