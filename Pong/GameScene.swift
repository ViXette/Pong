//
//  GameScene.swift
//  Pong
//
//  Created by VX on 19/11/2016.
//  Copyright © 2016 VXette. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
	
	var ball = SKSpriteNode()
	var enemy = SKSpriteNode()
	var main = SKSpriteNode()
	
	var mainScore = SKLabelNode()
	var enemyScore = SKLabelNode()
	
	var score = [0, 0]
	
	let impulse = 15
    
	override func didMove(to view: SKView) {
		ball = self.childNode(withName: "ball") as! SKSpriteNode
		enemy = self.childNode(withName: "enemy") as! SKSpriteNode
		main = self.childNode(withName: "main") as! SKSpriteNode
		
		mainScore = self.childNode(withName: "mainScore_label") as! SKLabelNode
		enemyScore = self.childNode(withName: "enemyScore_label") as! SKLabelNode

		ball.physicsBody?.applyImpulse(CGVector(dx: impulse, dy: impulse))

		let border = SKPhysicsBody(edgeLoopFrom: self.frame)
		border.friction = 0
		border.restitution = 1

		self.physicsBody = border
	}
	
	func startGame() {
		score = [0, 0]
		mainScore.text = String(score[0])
		enemyScore.text = String(score[1])
	}
	
	func addScore(playerWhoWon :SKSpriteNode) {
		ball.position = CGPoint(x: 0, y: 0)
		ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
		
		if playerWhoWon == main {
			score[0] += 1
			mainScore.text = String(score[0])
			ball.physicsBody?.applyImpulse(CGVector(dx: impulse, dy: impulse))
		} else if playerWhoWon == enemy {
			score[1] += 1
			enemyScore.text = String(score[1])
			ball.physicsBody?.applyImpulse(CGVector(dx: -1 * impulse, dy: -1 * impulse))
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			
			main.run(SKAction.moveTo(x: location.x, duration: 0.4))
		}
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let location = touch.location(in: self)
			
			main.run(SKAction.moveTo(x: location.x, duration: 0.4))
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
		
		if ball.position.y <= main.position.y - 70 {
			addScore(playerWhoWon: enemy)
		} else if ball.position.y >= enemy.position.y + 70 {
			addScore(playerWhoWon: main)
		}
	}
	
}
