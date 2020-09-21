import SpriteKit
 
class TitleScene: SKScene {
    
    private let windowSize : CGSize = UIScreen.main.bounds.size
    
    override func didMove(to view: SKView) {
        
        let titleLabel = SKLabelNode(fontNamed:"Chalkduster")
        titleLabel.text = "Three Color Shooting"
        titleLabel.color = .black
        titleLabel.fontSize = 25
        titleLabel.position = CGPoint(x: windowSize.width / 2, y: windowSize.height - 80)
        self.addChild(titleLabel)
        
        let description = SKSpriteNode(imageNamed: "description.png")
        description.position = CGPoint(x: windowSize.width / 2, y : windowSize.height / 2)
        description.size = CGSize(width: (windowSize.width / 3) * 2, height: (windowSize.height / 3) * 2)
        self.addChild(description)
        
        let startLabel = SKLabelNode(fontNamed: "Copperplate")
        startLabel.text = "Start"
        startLabel.fontSize = 36
        startLabel.position = CGPoint(x: windowSize.width / 2, y: 50)
        startLabel.name = "Start"
        self.addChild(startLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(_: location)
            
            if (touchedNode.name != nil) {
                //「Start」ラベルをタップするとゲームを開始する
                if (touchedNode.name == "Start"){
                    let view = self.view!
                    let scene = GameScene()
                    scene.size = view.frame.size
                    scene.scaleMode = .aspectFill
                    view.presentScene(scene)
                    
                }
            }
        }
    }
}
