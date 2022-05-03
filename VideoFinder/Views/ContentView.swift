

import SwiftUI

struct ContentView: View {
    @StateObject var videoManager = VideoManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            HStack (spacing: 0){
                VStack {
                    ForEach(Query.allCases, id: \.self) { searchQuery in
                            LazyHStack(spacing: 20){
                            QueryTag(query: searchQuery, isSelected: videoManager.selectedQuery == searchQuery)
                                .onTapGesture {
                                    // When the user taps on a QueryTag, we'll change the selectedQuery from VideoManager
                                    videoManager.selectedQuery = searchQuery
                                }
                        }
                    }
                }
                .padding(.leading,10)
                
                ScrollView {
                    if videoManager.videos.isEmpty {
                        ProgressView()
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(videoManager.videos, id: \.id) { video in
                                NavigationLink {
                                    VideoView(video: video)
                                } label: {
                                    VideoCard(video: video)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
            }
//            .background(Color("AccentColor"))
//            .background(Color.black)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
