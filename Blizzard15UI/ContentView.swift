//
//  ContentView.swift
//  Blizzard15UI
//
//  Created by Redentic on 10/02/2022.
//

import SwiftUI

enum PackageManager: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case zebra = "Zebra"
    case sileo = "Sileo"
    case installer = "Installer 5"
}

struct ContentView: View {
    @State private var packageManager: PackageManager = .zebra
    @State private var blockPirateRepos = true
    @State private var showWarning = false
    @State private var tableHeight = 100.0
    
    init() {
        UIScrollView.appearance().bounces = false
        if #unavailable(iOS 16.0) {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [.purple.opacity(0.7), .blue.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            // Content
            VStack {
                Spacer()
                
                HStack(alignment: .center) {
                    VStack {
                        // Header
                        VStack {
                            Image("Logo")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal, 100)
                            Text("Blizzard Jailbreak")
                                .textCase(.uppercase)
                                .font(.title)
                            Text("iOS 15.0 - 16.0.2")
                        }
                        .padding(.vertical)
                        
                        // Main button
                        Button {
                            // TODO: Install package manager
                        } label: {
                            Text("Install \(packageManager.rawValue)")
                        }
                        .buttonStyle(BoldTrayButton())
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .if({
                            if #available(iOS 16.0, *) {
                                return true
                            }
                            return false
                        }()) {
                            $0.padding(.bottom, 10)
                        }
                        
                        // Controls
                        if #available(iOS 16.0, *) {
                            controls
                                .scrollContentBackground(.hidden)
                                .background(GeometryReader { geo -> Color in
                                    DispatchQueue.main.async {
                                        self.tableHeight = geo.size.width // for some reason .width works whereas it should be .height
                                    }
                                    return .clear
                                })
                                .frame(maxHeight: tableHeight)
                        } else {
                            controls
                                .background(GeometryReader { geo -> Color in
                                    DispatchQueue.main.async {
                                        self.tableHeight = geo.size.width
                                    }
                                    return .clear
                                })
                                .frame(maxHeight: tableHeight)
                        }
                    }
                }
                
                Spacer()
                
                // Credits
                VStack {
                    Text("\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
                        .font(.headline)
                        .padding(.bottom, 1)
                    Text("by GeoSn0w ([@FCE365](https://twitter.com/FCE365))")
                    Text("UI by Redentic ([@RedenticDev](https://twitter.com/RedenticDev))")
                }
                .tint(Color(uiColor: UIColor { traitCollection in
                    traitCollection.userInterfaceStyle == .light ? .blue.withAlphaComponent(0.7) : .systemCyan
                }))
                .padding(.bottom)
            }
            .foregroundColor(.white)
            .frame(maxWidth: 400)
        }
    }
    
    var controls: some View {
        Form {
            Section {
                Toggle(isOn: $blockPirateRepos) {
                    Text("Block pirate repositories")
                }
                VStack {
                    if #unavailable(iOS 16.0) {
                        Text("Package manager")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 5)
                    }
                    Picker("Package manager", selection: $packageManager) {
                        ForEach(PackageManager.allCases) { manager in
                            Text(manager.rawValue)
                        }
                    }
                    .if({
                        if #available(iOS 16.0, *) {
                            return false
                        }
                        return true
                    }()) {
                        $0.pickerStyle(.segmented)
                    }
                }
            } header: {
                Text("Settings")
                    .foregroundColor(.white)
            }
            .listRowBackground(
                Color.clear
                    .background(.thinMaterial)
            )
            
            Section {
                Button {
                    showWarning.toggle()
                } label: {
                    Text("Uninstall Blizzard")
                        .foregroundColor(.red)
                }
                .confirmationDialog("Blizzard Jailbreak", isPresented: $showWarning, titleVisibility: .visible) {
                    Button(role: .destructive) {
                        // TODO: Uninstall
                    } label: {
                        Text("Uninstall")
                    }
                } message: {
                    Text("Do you really want to uninstall Blizzard?\nThis will remove jailbreak files & changes, without erasing your data. Your \(UIDevice.current.localizedModel) will reboot.")
                }
            } header: {
                Text("Uninstall")
                    .foregroundColor(.white)
            }
            .listRowBackground(
                Color.clear
                    .background(.thinMaterial)
            )
        }
        .foregroundColor(Color(uiColor: .label))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
