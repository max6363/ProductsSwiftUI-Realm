//
//  ProductItemRow.swift
//  ProductsSwiftUI-Realm
//
//  Created by Minhaz on 10/12/21.
//

import Foundation
import SwiftUI

struct ProductItemRow: View {
    
    var product: Product
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                if let urlString = product.photos.first,
                    let url = URL(string: urlString) {
                    HStack {
                        AsyncImage(url: url)
                            .background(Color.gray)
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 0, maxWidth: .infinity,
                                   minHeight: 0, maxHeight: 180)
                        
                    }
                    .clipped()
                }
             
                HStack {
                    Text(product.title)
                        .font(.system(size: 22, weight: .medium, design: .default))
                    Spacer()
                    Text(String(format: "$%.2f", product.price))
                        .font(.system(size: 19, weight: .regular, design: .default))
                }
                .padding(8)
            }
            
            HStack {
                Text(product.dateAdded.formatted())
                    .font(.callout)
                    .padding(5)
                    .foregroundColor(.black)
            }
            .background(Color.white)
            .cornerRadius(5)
            .padding(5)
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 0.8)
        )
    }
}
