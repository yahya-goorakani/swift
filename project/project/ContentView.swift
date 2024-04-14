//
//  ContentView.swift
//  project
//
//  Created by Yahya Goorakani on 2/23/24.
//


import SwiftUI
import SceneKit

struct ContentView: View {
    @State private var word: String = "?"
    @State private var textColor: Color = .blue // Initial text color
    @State private var fontSize: CGFloat = 20.0 // Initial font size
    @State private var backgroundColor: Color = .teal // Initial background color
    @State private var TextColor: Color = .teal // Initial text color on the left side

    var body: some View {
        VStack {
            HStack {
                ColorPicker("Text Color", selection: $TextColor)
                ColorPicker("Background Color", selection: $backgroundColor)
                //.padding()
                //Spacer()
            }
           // .padding(.horizontal) // Add horizontal padding for the HStack
            
            TextField("Enter a word", text: $word)
              //  .padding()
               
            Slider(value: $fontSize, in: 10...50, step: 1)
                //.padding()
          
            
            SceneKitView(word: word, textColor: textColor, TextColor:TextColor, fontSize: fontSize)
                .frame(width: 600, height: 300)
                .background(backgroundColor) // Apply background color here
                //.padding()
            
            Text("Current Word: \(word)")
        }
        //.padding()
        .background(backgroundColor) // Apply background color to the entire VStack
        .edgesIgnoringSafeArea(.all) // Ignore safe area edges for background color
    }
}

struct SceneKitView: NSViewRepresentable {
    var word: String
    var textColor: Color
    var TextColor: Color
    var fontSize: CGFloat

    func makeNSView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true

        let scene = SCNScene()
        sceneView.scene = scene

        let textGeometry = SCNText(string: word, extrusionDepth: 1.0)
        textGeometry.font = NSFont.systemFont(ofSize: fontSize)
        textGeometry.firstMaterial?.diffuse.contents = NSColor(textColor) // Convert SwiftUI Color to NSColor

        let textNode = SCNNode(geometry: textGeometry)
        scene.rootNode.addChildNode(textNode)

        return sceneView
    }

    func updateNSView(_ nsView: SCNView, context: Context) {
        guard let textGeometry = nsView.scene?.rootNode.childNodes.first?.geometry as? SCNText else { return }
        textGeometry.string = word
        textGeometry.font = NSFont.systemFont(ofSize: fontSize)
        textGeometry.firstMaterial?.diffuse.contents = NSColor(TextColor) // Convert SwiftUI Color to NSColor for left text color
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
