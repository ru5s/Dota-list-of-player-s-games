//
//  SettingsV.swift
//  Dota Dairy
//
//  Created by Den on 07/03/24.
//

import SwiftUI
import Combine

struct SettingsV: View {
    @ObservedObject var model: SettingsVM = SettingsVM()
    var cancellables = Set<AnyCancellable>()
    @State var openWWebView: Bool = false
    private let usagePolicyLink: String = "https://www.goolgle.com"
    @State var deleteAllDataAlert: Bool = false
    var body: some View {
        NavigationView(content: {
            VStack {
                    VStack {
                        NavigationLink(isActive: $openWWebView, destination: {
                            WView(urlString: usagePolicyLink)
                                .navigationBarTitleDisplayMode(.inline)
                        }, label: {EmptyView()})
                        VStack(spacing: 0, content: {
                            Button {
                                openWWebView.toggle()
                            } label: {
                                HStack {
                                    Image(systemName: "doc.text.fill")
                                    ZStack(alignment: .bottom) {
                                        HStack {
                                            Text("Usage Policy")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                }
                            }
                            .padding(15)
                            .background(Color.ddBlue)
                            
                            HStack {
                                HStack {}
                                    .frame(height: 1)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.ddWhite.opacity(0.5))
                            }
                            .padding(.leading, 40)
                            .background(Color.ddBlue)
                            
                            Button {
                                model.sharedApp()
                            } label: {
                                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                                    Image(systemName: "square.and.arrow.up.fill")
                                    ZStack(alignment: .bottom) {
                                        HStack {
                                            Text("Share App")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                        }
                                    }
                                })
                            }
                            .padding(15)
                            .background(Color.ddBlue)
                            HStack {
                                HStack {}
                                    .frame(height: 1)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.ddWhite.opacity(0.5))
                            }
                            .padding(.leading, 40)
                            .background(Color.ddBlue)
                            Button {
                                model.rateApp()
                            } label: {
                                Image(systemName: "star.fill")
                                ZStack(alignment: .bottom) {
                                    HStack {
                                        Text("Rate Us")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                }
                            }
                            .padding(15)
                            .background(Color.ddBlue)
                        })
                        .foregroundColor(Color.ddWhite)
                        .cornerRadiusWithBorder(radius: 10, borderLineWidth: 0.5, borderColor: Color.ddBlue, antialiased: true)
                        .padding(.top, 25)
                        Spacer()
                        ButtonRounded(title: "Reset progress", completion: {
                            deleteAllDataAlert.toggle()
                        }, state: .constant(true), backgroundColor: Color.ddBlue)
                        .padding(.bottom, 20)
                    }
            }
            .padding(16)
            .navigationTitle("Settings")
        })
        .alert(isPresented: $deleteAllDataAlert, content: {
            Alert(
                title: Text("Warning!"),
                message: Text("Delete all data"),
                primaryButton: 
                        .default(Text("Ok"),
                                 action: {
                                     model.deleteAllData()
                                     deleteAllDataAlert.toggle()
                                 }),
                secondaryButton: .cancel())
        })
        .onAppear {
            navigationSettings()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func navigationSettings() {
        let coloredNavAppearance = UINavigationBarAppearance()
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor.active
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.ddWhite]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.ddWhite]
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
}

#Preview {
    SettingsV()
}
