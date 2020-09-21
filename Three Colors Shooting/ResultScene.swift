import SpriteKit
 
class ResultScene: SKScene {
    
    private let windowSize : CGSize = UIScreen.main.bounds.size
    public var numberOfScore = 0
    
    override func didMove(to view: SKView) {

        let titleLabel = SKLabelNode(fontNamed:"Chalkduster")
        titleLabel.text = "Game Over"
        titleLabel.color = .black
        titleLabel.fontSize = 25
        titleLabel.position = CGPoint(x: windowSize.width / 2, y: 50)
        self.addChild(titleLabel)
        
        let score = SKLabelNode(fontNamed:"Copperplate")
        score.text = "スコア : " + self.numberOfScore.description
        score.color = .black
        score.fontSize = 25
        score.position = CGPoint(x: windowSize.width / 2, y: windowSize.height / 2)
        self.addChild(score)
        
        let returnLabel = SKLabelNode(fontNamed: "Copperplate")
        returnLabel.text = "タイトルに戻る"
        returnLabel.fontSize = 36
        returnLabel.position = CGPoint(x: windowSize.width / 2, y: windowSize.height - 100)
        returnLabel.name = "Return"
        self.addChild(returnLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(_: location)
            
            if (touchedNode.name != nil) {
                if (touchedNode.name == "Return"){
                    let view = self.view!
                    let scene = TitleScene()
                    scene.size = view.frame.size
                    view.presentScene(scene)
                }
            }
        }
    }
}

