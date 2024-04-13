
//import SwiftUI
//import SceneKit
////
////struct ContentView: View {
////    var body: some View {
////        SceneKitView()
////            .frame(width: 400, height: 500)
////
////    }
////}
//
//
//struct ContentView: View {
//    @State private var sphereColor: Color = .random
//    @State private var backgroundColor: Color = .random
//    @State private var sphereLinesColor: Color = .random
//    var body: some View {
//        VStack {
//            HStack {
//                Button("Change Sphere Color") {
//                    sphereColor = .random
//                }
//                Button("Change Background Color") {
//                    backgroundColor = .random
//                }
//                Button("Change Sphere Lines Color") {
//                    sphereLinesColor = .random
//                }
//
//
//            }
//            .padding()
//            .frame(height: 50) // Adjust height as needed
//
//            SceneKitView(sphereColor: sphereColor, backgroundColor: backgroundColor, sphereLinesColor: sphereLinesColor)
//                .frame(width: 400, height: 500)
//        }
//    }
//}
//
//struct SceneKitView : NSViewRepresentable {
//    var sphereColor: Color
//    var backgroundColor: Color
//    var sphereLinesColor: Color
//    func makeNSView(context: Context) -> SCNView {
//        let sceneView = SCNView()
//        sceneView.allowsCameraControl = true
//        sceneView.backgroundColor = NSColor(backgroundColor)
//
//        let scene = SCNScene()
//        sceneView.scene = scene
//
//                let sphereGeometry = SCNSphere(radius: 1.0)
//                let sphereNode = SCNNode(geometry: sphereGeometry)
//  //              let sphereNode = SCNNode()
//
//
//        scene.rootNode.addChildNode(sphereNode)
//
//        let degreeResolution: Double = 10.0
//
//        for phiAngle in stride(from: 0.0, to: 180.0, by: degreeResolution){
//            let phi : Float = Float(phiAngle * .pi/180.0)
//            addCageLines(node: scene.rootNode, phi: phi, theta: .pi/2, radius: 1.0, center_y: 0.0)
//        }
//
//        for angle in stride(from: -90.0, to: 90.0, by: degreeResolution){
//            let radius: Float = Float(cos(angle * .pi/180.0))
//            let y: Float = Float(sin(angle * .pi/180.0))
//            addCageLines(node: scene.rootNode, phi: 0.0, theta: 0.0, radius: radius, center_y: y)
//        }
//
//
//
//
//        return sceneView
//    }
//
//    func updateNSView(_ nsView: SCNView, context: Context) { nsView.backgroundColor = NSColor(backgroundColor)
//nsView.scene?.rootNode.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = NSColor(sphereColor)}
//
//    private func addCageLines(node: SCNNode ,phi: Float, theta: Float, radius: Float, center_y: Float) {
//
//
//        // Create a tube geometry to represent the line with width
//        let tubeGeometry = SCNTube(innerRadius: CGFloat(radius * 0.99), outerRadius: CGFloat(radius * 1.01), height: 0.01)
//        let tubeNode = SCNNode(geometry: tubeGeometry)
//
//        // Set color for the tube (e.g., blue)
//        let material = SCNMaterial()
//        material.diffuse.contents = NSColor(sphereColor)
//        tubeGeometry.firstMaterial = material
//
//        // Position and orient the tube along the circumference
//        tubeNode.position = SCNVector3(0, center_y, 0)
//        tubeNode.eulerAngles.x = CGFloat(theta)
//        tubeNode.eulerAngles.y = CGFloat(phi)
//
//        node.addChildNode(tubeNode)
//
//            func updateNSView(_ nsView: SCNView, context: Context) {
//                nsView.backgroundColor = NSColor(backgroundColor)
//                nsView.scene?.rootNode.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = NSColor(sphereColor)
//            }
//
//    }
//
//}
//extension Color {
//    static var random: Color {
//        let red = Double.random(in: 0...1)
//        let green = Double.random(in: 0...1)
//        let blue = Double.random(in: 0...1)
//        return Color(red: red, green: green, blue: blue)
//    }
//}
//
//extension SCNGeometry {
//        class func lineFrom(vector3Array: [SCNVector3]) -> SCNGeometry {
//            let sources = SCNGeometrySource(vertices: vector3Array)
//
//            var indices: [Int32] = []
//            for i in 0..<vector3Array.count {
//                indices.append(Int32(i))
//            }
//
//            let element = SCNGeometryElement(indices: indices, primitiveType: .line)
//
//            return SCNGeometry(sources: [sources], elements: [element])
//        }
//    }
//
//
//
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }




import SwiftUI
import SceneKit

struct ContentView: View {
    @State private var sphereColor: Color = .random
    @State private var backgroundColor: Color = .random
    @State private var sphereLinesColor: Color = .random
    @State private var is3DModeOn: Bool = true
    @State private var sphereOn: Bool = true
    @State private var sphereAndLinesOn: Bool = true

    var body: some View {
        VStack {
            HStack {
                Button("Change Sphere Color") {
                    sphereColor = .random
                }
                Button("Change Background Color") {
                    backgroundColor = .random
                }
                Button("Change Sphere Lines Color") {
                    sphereLinesColor = .random
                }
                Button(is3DModeOn ? "Turn Off 3D Mode" : "Turn On 3D Mode") {
                    is3DModeOn.toggle()
                }
                Button(sphereOn ? "Hide Sphere" : "Show Sphere") {
                    sphereOn.toggle()
                }
                Button(sphereAndLinesOn ? "Hide Sphere and Linse" : "Show Sphere and Linse") {
                    sphereAndLinesOn.toggle()
                }
                
            }
            .padding()
            .frame(height: 50) // Adjust height as needed

            SceneKitView(sphereColor: sphereColor, backgroundColor: backgroundColor, sphereLinesColor: sphereLinesColor, is3DModeOn: is3DModeOn, sphereOn: sphereOn, sphereAndLinesOn: sphereAndLinesOn)
                .frame(width: 400, height: 500)
        }
    }
}

struct SceneKitView: NSViewRepresentable {
    var sphereColor: Color
    var backgroundColor: Color
    var sphereLinesColor: Color
    var is3DModeOn: Bool
    var sphereOn: Bool
    var sphereAndLinesOn: Bool
    
    func makeNSView(context: Context) -> SCNView {
        let sceneView = SCNView()
        configureSceneView(sceneView)
        return sceneView
    }
    
    func updateNSView(_ nsView: SCNView, context: Context) {
        configureSceneView(nsView)
    }
    
    private func configureSceneView(_ sceneView: SCNView) {
        sceneView.scene = SCNScene()
        sceneView.allowsCameraControl = is3DModeOn
        sceneView.backgroundColor = NSColor(backgroundColor)
        
        if sphereAndLinesOn {
            let sphereGeometry = SCNSphere(radius: 1.0)
            let sphereNode = SCNNode(geometry: sphereGeometry)
          sphereNode.geometry?.firstMaterial?.diffuse.contents = NSColor(sphereColor)
            sceneView.scene?.rootNode.addChildNode(sphereNode)
            let degreeResolution: Double = 10.0
            
            for phiAngle in stride(from: 0.0, to: 180.0, by: degreeResolution) {
                let phi: Float = Float(phiAngle * .pi / 180.0)
                addCageLines(node: sceneView.scene!.rootNode, phi: phi, theta: .pi / 2, radius: 1.0, center_y: 0.0, color: NSColor(sphereLinesColor))
            }
                for angle in stride(from: -90.0, to: 90.0, by: degreeResolution) {
                    let radius: Float = Float(cos(angle * .pi / 180.0))
                    let y: Float = Float(sin(angle * .pi / 180.0))
                    addCageLines(node: sceneView.scene!.rootNode, phi: 0.0, theta: 0.0, radius: radius, center_y: y, color: NSColor(sphereLinesColor))
        }
            
        }else {
            
            func makeNSView(context: Context) -> SCNView {
                let sceneView = SCNView()
                configureSceneView(sceneView)
                return sceneView
            }

        }
        if sphereOn {
            let sphereGeometry = SCNSphere(radius: 1.0)
            let sphereNode = SCNNode(geometry: sphereGeometry)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = NSColor(sphereColor)
            sceneView.scene?.rootNode.addChildNode(sphereNode)
            
        }else {
            _ = SCNSphere(radius: 1.0)
            let sphereNode = SCNNode()
            sphereNode.geometry?.firstMaterial?.diffuse.contents = NSColor(sphereColor)
            sceneView.scene?.rootNode.addChildNode(sphereNode)
            if is3DModeOn {
                let degreeResolution: Double = 10.0
                
                for phiAngle in stride(from: 0.0, to: 180.0, by: degreeResolution) {
                    let phi: Float = Float(phiAngle * .pi / 180.0)
                    addCageLines(node: sceneView.scene!.rootNode, phi: phi, theta: .pi / 2, radius: 1.0, center_y: 0.0, color: NSColor(sphereLinesColor))
                }
                    for angle in stride(from: -90.0, to: 90.0, by: degreeResolution) {
                        let radius: Float = Float(cos(angle * .pi / 180.0))
                        let y: Float = Float(sin(angle * .pi / 180.0))
                        addCageLines(node: sceneView.scene!.rootNode, phi: 0.0, theta: 0.0, radius: radius, center_y: y, color: NSColor(sphereLinesColor))
                    }
            }else {
                let degreeResolution: Double = 10.0
                
                for phiAngle in stride(from: 0.0, to: 180.0, by: degreeResolution) {
                    let phi: Float = Float(phiAngle * .pi / 180.0)
                    addCageLines(node: sceneView.scene!.rootNode, phi: phi, theta: .pi / 2, radius: 1.0, center_y: 0.0, color: NSColor(sphereLinesColor))
                }
                    for angle in stride(from: -90.0, to: 90.0, by: degreeResolution) {
                        let radius: Float = Float(cos(angle * .pi / 180.0))
                        let y: Float = Float(sin(angle * .pi / 180.0))
                        addCageLines(node: sceneView.scene!.rootNode, phi: 0.0, theta: 0.0, radius: radius, center_y: y, color: NSColor(sphereLinesColor))
            }
            }
        }
    }
    private func addCageLines(node: SCNNode, phi: Float, theta: Float, radius: Float, center_y: Float, color: NSColor) {
        let tubeGeometry = SCNTube(innerRadius: CGFloat(radius * 0.99), outerRadius: CGFloat(radius * 1.01), height: 0.01)
        let tubeNode = SCNNode(geometry: tubeGeometry)

        let material = SCNMaterial()
        material.diffuse.contents = color
        tubeGeometry.firstMaterial = material

        tubeNode.position = SCNVector3(0, center_y, 0)
        tubeNode.eulerAngles.x = CGFloat(theta)
        tubeNode.eulerAngles.y = CGFloat(phi)

        node.addChildNode(tubeNode)
    }
}

extension Color {
    static var random: Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}



