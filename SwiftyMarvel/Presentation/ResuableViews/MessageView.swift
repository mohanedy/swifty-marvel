//
//  MessageView.swift
//  SwiftyMarvel
//
//  Created by Mohaned Yossry on 10/07/2023.
//

import SwiftUI

struct MessageView: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: "Hello World!")
    }
}
