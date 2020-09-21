import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var rightWall :SKShapeNode?
    private var leftWall : SKShapeNode?
    private var deadLine : SKShapeNode?
    private var redTarget : SKShapeNode?
    private var blueTarget : SKShapeNode?
    private var yellowTarget : SKShapeNode?
    private var redBullet : SKShapeNode?
    private var blueBullet : SKShapeNode?
    private var yellowBullet : SKShapeNode?

    private let windowSize : CGSize = UIScreen.main.bounds.size
    
    private var scoreLabel : SKLabelNode?
    private var NumberOfScore = 0
    
    private var waitFireFlag : Bool?
    
    let deadLineCategory : UInt32 = 1 << 1
    let redCategory : UInt32 = 1 << 2
    let blackCategory : UInt32 = 1 << 3
    let wallCategory : UInt32 = 1 << 4
    let redBulletCategory : UInt32 = 1 << 5
    let blueBulletCategory : UInt32 = 1 << 6
    let yellowBulletCategory : UInt32 = 1 << 7
    let redTargetCategory : UInt32 = 1 << 8
    let blueTargetCategory : UInt32 = 1 << 9
    let yellowTargetCategory : UInt32 = 1 << 10
    
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.restitution = 1
        
        self.waitFireFlag = true
        
        self.rightWall = SKShapeNode.init(rectOf: CGSize.init(width: 20, height: windowSize.height * 2), cornerRadius: 0)
        self.leftWall = SKShapeNode.init(rectOf: CGSize.init(width: 20, height: windowSize.height * 2), cornerRadius: 0)
        
        self.scoreLabel = SKLabelNode.init()
        if let score = self.scoreLabel {
            score.text = "スコア : " + self.NumberOfScore.description
            score.fontColor = .black
            score.horizontalAlignmentMode = .left
            score.zPosition = 1
            score.fontSize = 16
            score.position = CGPoint(x: 20, y: windowSize.height - 50)
            self.addChild(score)
        }
        
        if let rightWall = self.rightWall {
            rightWall.fillColor = .black
            rightWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: windowSize.height * 2))
            rightWall.physicsBody?.affectedByGravity = false
            rightWall.physicsBody?.friction = 0
            rightWall.physicsBody?.linearDamping = 0
            rightWall.physicsBody?.restitution = 1
            rightWall.physicsBody?.isDynamic = false
            rightWall.position = CGPoint(x: windowSize.width, y: 0)
            self.addChild(rightWall)
        }
        
        if let leftWall = self.leftWall {
            leftWall.fillColor = .black
            leftWall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: windowSize.height * 2))
            leftWall.physicsBody?.affectedByGravity = false
            leftWall.physicsBody?.friction = 0
            leftWall.physicsBody?.linearDamping = 0
            leftWall.physicsBody?.restitution = 1
            leftWall.physicsBody?.isDynamic = false
            leftWall.position = CGPoint(x: 0, y: 0)
            self.addChild(leftWall)
        }
        
        self.redBullet = SKShapeNode.init(rectOf: CGSize.init(width: 10, height: 10), cornerRadius: 10)
        if let redBullet = self.redBullet {
            redBullet.fillColor = .black
            redBullet.strokeColor = .red
            redBullet.lineWidth = 3
            redBullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
            redBullet.physicsBody?.velocity = CGVector(dx: 0, dy: 1000)
            redBullet.physicsBody?.affectedByGravity = false
            redBullet.physicsBody?.friction = 0
            redBullet.physicsBody?.linearDamping = 0
            redBullet.physicsBody?.restitution = 1
            redBullet.physicsBody?.isDynamic = true
        }
        
        self.blueBullet = SKShapeNode.init(rectOf: CGSize.init(width: 10, height: 10), cornerRadius: 10)
        if let blueBullet = self.blueBullet {
            blueBullet.fillColor = .black
            blueBullet.strokeColor = .blue
            blueBullet.lineWidth = 3
            blueBullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
            blueBullet.physicsBody?.velocity = CGVector(dx: 0, dy: 1000)
            blueBullet.physicsBody?.affectedByGravity = false
            blueBullet.physicsBody?.friction = 0
            blueBullet.physicsBody?.linearDamping = 0
            blueBullet.physicsBody?.restitution = 1
            blueBullet.physicsBody?.isDynamic = true
        }
        
        self.yellowBullet = SKShapeNode.init(rectOf: CGSize.init(width: 10, height: 10), cornerRadius: 10)
        if let yellowBullet = self.yellowBullet {
            yellowBullet.fillColor = .black
            yellowBullet.strokeColor = .yellow
            yellowBullet.lineWidth = 3
            yellowBullet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 10))
            yellowBullet.physicsBody?.velocity = CGVector(dx: 0, dy: 1000)
            yellowBullet.physicsBody?.affectedByGravity = false
            yellowBullet.physicsBody?.friction = 0
            yellowBullet.physicsBody?.linearDamping = 0
            yellowBullet.physicsBody?.restitution = 1
            yellowBullet.physicsBody?.isDynamic = true
        }
        
        self.redTarget = SKShapeNode.init(rectOf: CGSize.init(width: 20, height: 20), cornerRadius: 20)
        if let redTarget = self.redTarget {
            redTarget.fillColor = .red
            redTarget.strokeColor = .black
            redTarget.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
            redTarget.physicsBody?.affectedByGravity = false
            redTarget.physicsBody?.friction = 0
            redTarget.physicsBody?.linearDamping = 0
            redTarget.physicsBody?.restitution = 1
            redTarget.physicsBody?.isDynamic = true
        }
        
        self.blueTarget = SKShapeNode.init(rectOf: CGSize.init(width: 20, height: 20), cornerRadius: 20)
        if let blueTarget = self.blueTarget {
            blueTarget.fillColor = .blue
            blueTarget.strokeColor = .black
            blueTarget.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
            blueTarget.physicsBody?.affectedByGravity = false
            blueTarget.physicsBody?.friction = 0
            blueTarget.physicsBody?.linearDamping = 0
            blueTarget.physicsBody?.restitution = 1
            blueTarget.physicsBody?.isDynamic = true
        }
        
        self.yellowTarget = SKShapeNode.init(rectOf: CGSize.init(width: 20, height: 20), cornerRadius: 20)
        if let yellowTarget = self.yellowTarget {
            yellowTarget.fillColor = .yellow
            yellowTarget.strokeColor = .black
            yellowTarget.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
            yellowTarget.physicsBody?.affectedByGravity = false
            yellowTarget.physicsBody?.friction = 0
            yellowTarget.physicsBody?.linearDamping = 0
            yellowTarget.physicsBody?.restitution = 1
            yellowTarget.physicsBody?.isDynamic = true
        }
        
        self.deadLine = SKShapeNode.init(rectOf: CGSize.init(width: windowSize.width * 2, height: 10), cornerRadius: 0)
        if let deadLine = self.deadLine {
            deadLine.fillColor = .purple
            deadLine.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: windowSize.width * 2, height: 10))
            deadLine.physicsBody?.affectedByGravity = false
            deadLine.physicsBody?.friction = 0
            deadLine.physicsBody?.linearDamping = 0
            deadLine.physicsBody?.restitution = 0
            deadLine.physicsBody?.isDynamic = false
            deadLine.position = CGPoint(x: 0, y: 50)
            self.addChild(deadLine)
        }
        
        let redCanon = SKSpriteNode(imageNamed: "redCanon.png")
        redCanon.position = CGPoint(x: 60, y : 80)
        redCanon.zPosition = 1
        redCanon.name = "redCanon"
        redCanon.setScale(0.1)
        self.addChild(redCanon)
        
        let blueCanon = SKSpriteNode(imageNamed: "blueCannon.png")
        blueCanon.position = CGPoint(x: windowSize.width / 2, y : 80)
        blueCanon.zPosition = 1
        blueCanon.name = "blueCanon"
        blueCanon.setScale(0.1)
        self.addChild(blueCanon)
        
        let yellowCanon = SKSpriteNode(imageNamed: "yellowCanon.png")
        yellowCanon.position = CGPoint(x: windowSize.width - 60, y : 80)
        yellowCanon.zPosition = 1
        yellowCanon.name = "yellowCanon"
        yellowCanon.setScale(0.1)
        self.addChild(yellowCanon)
        
        rightWall!.physicsBody!.categoryBitMask = wallCategory
        leftWall!.physicsBody!.categoryBitMask = wallCategory
        deadLine!.physicsBody!.categoryBitMask = deadLineCategory
        redBullet!.physicsBody!.categoryBitMask = redBulletCategory
        blueBullet!.physicsBody!.categoryBitMask = blueBulletCategory
        yellowBullet!.physicsBody!.categoryBitMask = yellowBulletCategory
        redTarget!.physicsBody!.categoryBitMask = redTargetCategory
        blueTarget!.physicsBody!.categoryBitMask = blueTargetCategory
        yellowTarget!.physicsBody!.categoryBitMask = yellowTargetCategory
        deadLine!.physicsBody!.contactTestBitMask = redTargetCategory | blueTargetCategory | yellowTargetCategory
        redTarget!.physicsBody!.contactTestBitMask = redBulletCategory
        blueTarget!.physicsBody!.contactTestBitMask = blueBulletCategory
        yellowTarget!.physicsBody!.contactTestBitMask = yellowBulletCategory
        
        Timer.scheduledTimer(
          timeInterval: 0.60,
          target: self,
          selector: #selector(self.choseTargetColor(s_:)),
          userInfo: nil,
          repeats: true
        )
        
        Timer.scheduledTimer(
          timeInterval: 0.5,
          target: self,
          selector: #selector(self.updateScore(s_:)),
          userInfo: nil,
          repeats: true
        )
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if checkTargetDelete(contact: contact)
            {
                self.NumberOfScore += 10
                scoreLabel?.text = "スコア : " + self.NumberOfScore.description
                
                contact.bodyA.node!.removeFromParent()
                contact.bodyB.node!.removeFromParent()
        }
        else if checkTouchDeadline(contact: contact)
            {
                let view = self.view!
                let scene = ResultScene()
                scene.numberOfScore = self.NumberOfScore
                scene.size = view.frame.size
                view.presentScene(scene)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        if self.waitFireFlag == false {
            return
        }
        
        if let touch = touches.first as UITouch? {
            let location = touch.location(in: self)
                if self.atPoint(_: location).name == "redCanon" {
                    if let n = self.redBullet?.copy() as! SKShapeNode? {
                        n.position = CGPoint(x: 60, y: 80)
                        self.addChild(n)
                    }
               }
                else if self.atPoint(_: location).name == "blueCanon" {
                    if let n = self.blueBullet?.copy() as! SKShapeNode? {
                        n.position = CGPoint(x: windowSize.width / 2, y: 80)
                        self.addChild(n)
                    }
                }
                else if self.atPoint(_: location).name == "yellowCanon" {
                     if let n = self.yellowBullet?.copy() as! SKShapeNode? {
                        n.position = CGPoint(x: windowSize.width - 60, y: 80)
                        self.addChild(n)
                }
            }
            setWaitFireFlag()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
         //Called before each frame is rendered
    }
    
    private func setWaitFireFlag() {
        self.waitFireFlag = false
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.setBullet(s_:)), userInfo: nil, repeats: false)
    }
    
    
    private func shotCircle(target: SKShapeNode?){
        if let n = target?.copy() as! SKShapeNode? {
            var xSpead = Int.random(in: 300 ..< 500)
            let ySpead = Int.random(in: -250 ..< -100)
            let rightOrLeft = Bool.random()
            xSpead = rightOrLeft ? xSpead : -xSpead
            n.position = CGPoint(x : 50, y: windowSize.height)
            n.physicsBody?.velocity = CGVector(dx: xSpead, dy: ySpead)
            self.addChild(n)
        }
    }
    
    private func checkTargetDelete(contact: SKPhysicsContact) -> Bool {
        if (contact.bodyA.node?.physicsBody?.categoryBitMask == redTargetCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == redBulletCategory) ||
            (contact.bodyA.node?.physicsBody?.categoryBitMask == redBulletCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == redTargetCategory){
            return true
        }
        else if (contact.bodyA.node?.physicsBody?.categoryBitMask == blueTargetCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == blueBulletCategory) ||
            (contact.bodyA.node?.physicsBody?.categoryBitMask == blueBulletCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == blueTargetCategory){
            return true
        }
        else if (contact.bodyA.node?.physicsBody?.categoryBitMask == yellowTargetCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == yellowBulletCategory) ||
            (contact.bodyA.node?.physicsBody?.categoryBitMask == yellowBulletCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == yellowTargetCategory){
            return true
        }
        
        return false
    }
    
    private func checkTouchDeadline(contact: SKPhysicsContact) -> Bool {
        if (contact.bodyA.node?.physicsBody?.categoryBitMask == deadLineCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == redTargetCategory) ||
            (contact.bodyA.node?.physicsBody?.categoryBitMask == redTargetCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == deadLineCategory){
            return true
        }
        else if (contact.bodyA.node?.physicsBody?.categoryBitMask == deadLineCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == blueTargetCategory) ||
            (contact.bodyA.node?.physicsBody?.categoryBitMask == blueTargetCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == deadLineCategory){
            return true
        }
        else if (contact.bodyA.node?.physicsBody?.categoryBitMask == deadLineCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == yellowTargetCategory) ||
            (contact.bodyA.node?.physicsBody?.categoryBitMask == yellowTargetCategory && contact.bodyB.node?.physicsBody?.categoryBitMask == deadLineCategory){
            return true
        }
        return false
    }
    
    @objc func updateScore(s_ sender: Timer) {
        self.NumberOfScore += 50
        scoreLabel?.text = "スコア : " + self.NumberOfScore.description
    }
    
    @objc func choseTargetColor(s_ sender: Timer) {
        let NumberOfColorSelect = Int.random(in: 0 ..< 3)
        
        switch NumberOfColorSelect {
        case 0:
            self.shotCircle(target: self.redTarget)
        case 1:
            self.shotCircle(target: self.blueTarget)
        case 2:
            self.shotCircle(target: self.yellowTarget)
        default:
            break
        }
    }
    
    @objc private func setBullet(s_ sender: Timer) {
        self.waitFireFlag = true
    }
}
