//
//  ContentView.swift
//  ImageAI
//
//  Created by Shahid on 02.12.22.
//

import SwiftUI
struct ContentView: View {
  @State private var prompt: String = ""
  @State  var image: UIImage? = nil
  @State private var isLoading: Bool = false
  @State var text: String = ""

    var body: some View {
      NavigationView {
        VStack(spacing: 30) {


            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(
                             gradient: Gradient(colors: [ .blue, .purple]),
                             startPoint: .top,
                             endPoint: .bottom))
                .opacity(0.5)

                .frame(width: 350, height: 450)
                .overlay {
                  if isLoading {
                  ActivityIndicator()
                  }
                }




          .padding(.top , -50)
          Text("Fantaziyanı burada yaz 😉")
            .font(.system(size: 20))
            .fontWeight(.medium)
            .padding(.trailing , 100)
            .padding(.top , -10)

          ZStack {
            TextField("..." , text: $text)
            RoundedRectangle(cornerRadius: 20)
              .stroke(lineWidth: 1)
              .frame(width: 350, height: 90)
          }


              Button(action: {
                isLoading = true

                Task {
                  do {
                    let response = try await
                    DallEImageGenerator.shared.generateImage(withPrompt: prompt, apiKey: "asda123")
                    if let url = response.data.map(\.url).first {
                                             let (data, _) = try await URLSession.shared.data(from: url)

                                             image = UIImage(data: data)
                                             isLoading = false
                                         }
                  }

                  catch {
                    print("error")
                  }
                }

              }) {
                ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.purple)
                  .frame(width: 350, height: 70)

Text("Generate")
              .fontWeight(.bold)
              .foregroundColor(.white)
              .font(.system(size:25))
            }
            }



          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {

              Text("Image Generator")
                  .font(.system(size: 32))

                  .fontWeight(.bold)

 }
            ToolbarItem( placement: .navigationBarTrailing) {

             Image(systemName: "person.fill")
                .font(.system(size: 36, weight: .regular))
                .foregroundColor(.purple)

                .padding()

            
          }
          }





      }




    }
      .padding(.top , 50)
      .padding(.leading , 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct ActivityIndicator: View {

    @State var degress = 0.0

    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.6)
            .stroke(.white, lineWidth: 5.0)
            .frame(width: 120, height: 120)
            .rotationEffect(Angle(degrees: degress))
            .onAppear(perform: {self.start()})
    }

    func start() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            withAnimation {
                self.degress += 10.0
            }
            if self.degress == 360.0 {
                self.degress = 0.0
            }
        }
    }
}
