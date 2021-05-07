import UIKit

class GameViewController: UIViewController {
    // core data store
    let store = ScoreStore()

    // Player variables
    var player_type = 0
    var player_hp = 0
    var player_atk = 0
    var player_def = 0
    
    // Boss variables
    var boss_type = 0
    var boss_hp = 0
    var boss_atk = 0
    var boss_name = ""
    
    // Hold the types of buttons
    var button_one_type = 0
    var button_two_type = 0
    var button_three_type = 0
    
    let model = GameModel()
    
    @IBOutlet weak var boss_image: UIImageView!
    @IBOutlet weak var player_image: UIImageView!
    @IBOutlet weak var button_one: UIButton!
    @IBOutlet weak var button_two: UIButton!
    @IBOutlet weak var button_three: UIButton!
    @IBOutlet weak var player_hp_label: UILabel!
    @IBOutlet weak var player_atk_label: UILabel!
    @IBOutlet weak var player_def_label: UILabel!
    @IBOutlet weak var boss_hp_label: UILabel!
    @IBOutlet weak var boss_atk_label: UILabel!
    @IBOutlet weak var boss_title: UILabel!
    @IBOutlet weak var player_move_log: UILabel!
    @IBOutlet weak var boss_move_log: UILabel!
    @IBOutlet weak var play_again_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.player_move_log.text = "Game Start!"
        self.boss_move_log.text = "Please choose an action to begin."
        self.play_again_button.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(updateBoss), name: Notification.Name("boss_created"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayer), name: Notification.Name("player_created"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtons), name: Notification.Name("buttons_updated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossHealth), name: Notification.Name("boss_heath_updated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerHealth), name: Notification.Name("player_heath_updated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossDead), name: Notification.Name("boss_died"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerDead), name: Notification.Name("player_died"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossCharged), name: Notification.Name("boss_charged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossUnCharge), name: Notification.Name("boss_uncharged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerPrepared), name: Notification.Name("player_prepared"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerHealed), name: Notification.Name("player_healed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerDefended), name: Notification.Name("player_defended"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBossStunned), name: Notification.Name("boss_stunned"), object: nil)

        
        model.generatePlayer(playerType: self.player_type)
        model.generateBoss()
        model.generateButtons()
    }
    
    func reset_move_logs(){
        self.player_move_log.textColor = UIColor.white
        self.boss_move_log.textColor = UIColor.white
    }

    
    @IBAction func button_one_pressed(_ sender: Any) {
        self.reset_move_logs()
        // attack returns how much attacked for...
        // can display the result here
        switch button_one_type {
        case 1:
            model.preform_attack()
        case 2:
            model.preform_defend()
        case 3:
            model.preform_heal()
        case 4:
            model.preform_special()
        case 5:
            model.preform_prep()
        default:
            print("None")
        }
        model.generateButtons()
    }
    @IBAction func button_two_pressed(_ sender: Any) {
        self.reset_move_logs()
        switch button_two_type {
        case 1:
            model.preform_attack()
        case 2:
            model.preform_defend()
        case 3:
            model.preform_heal()
        case 4:
            model.preform_special()
        case 5:
            model.preform_prep()
        default:
            print("None")
        }
        model.generateButtons()
    }
    @IBAction func button_three_pressed(_ sender: Any) {
        self.reset_move_logs()
        switch button_three_type {
        case 1:
            model.preform_attack()
        case 2:
            model.preform_defend()
        case 3:
            model.preform_heal()
        case 4:
            model.preform_special()
        case 5:
            model.preform_prep()
        default:
            print("None")
        }
        model.generateButtons()
    }
    
    @objc func updateBoss(){
        self.boss_type = model.boss_type
        self.boss_image.image = model.boss_image
        self.boss_hp = model.boss?.health ?? 0
        self.boss_atk = model.boss?.attack ?? 0
        self.boss_hp_label.text = String(self.boss_hp)
        self.boss_atk_label.text = String(self.boss_atk)
        // update the title on the view
        if self.boss_type == 1{
            self.boss_name = "Dragon"
            self.boss_title.text = "Dragon"
        }else if self.boss_type == 2{
            self.boss_name = "Wolf"
            self.boss_title.text = "Wolf"
        }
    }
    
    @objc func updatePlayer(){
        self.player_image.image = model.player_image
        self.player_hp = model.player?.health ?? 0
        self.player_atk = model.player?.attack ?? 0
        self.player_def = model.player?.defense ?? 0
        self.player_hp_label.text = String(self.player_hp)
        self.player_atk_label.text = String(self.player_atk)
        self.player_def_label.text = String(self.player_def)
    }
    
    @objc func updateButtons(){
        self.button_one.setImage(model.button_one_image, for: UIControl.State.normal)
        self.button_two.setImage(model.button_two_image, for: UIControl.State.normal)
        self.button_three.setImage(model.button_three_image, for: UIControl.State.normal)
        self.button_one_type = model.button_one_type
        self.button_two_type = model.button_two_type
        self.button_three_type = model.button_three_type
    }

    @objc func updateBossHealth(){
        self.boss_hp = model.boss?.health ?? 0
        self.boss_hp_label.text = String(self.boss_hp)
        let boss_dmg_taken = model.boss_dmg_taken
        self.animate_boss_dmg()
        self.player_move_log.attributedText = create_text_with_color_in_center(part1: "Player deals ", part2: "\(boss_dmg_taken) damage", part3: " to the \(self.boss_name)!", a_color: #colorLiteral(red: 0.9816971421, green: 0.01636762545, blue: 0.06224960834, alpha: 1))

    }
    
    @objc func updatePlayerHealth(){
        self.player_hp = model.player?.health ?? 0
        self.player_hp_label.text = String(self.player_hp)
        let player_dmg_taken = model.player_dmg_taken
        self.animate_player_dmg()

        self.boss_move_log.attributedText = create_text_with_color_in_center(part1: "\(self.boss_name) deals ", part2: "\(player_dmg_taken) damage", part3: " to the player!", a_color: #colorLiteral(red: 0.9816971421, green: 0.01636762545, blue: 0.06224960834, alpha: 1))
    }
    
    @objc func updateBossDead(){
        let victory_string = "Defeated " + self.boss_name + " in " + String(self.model.turns) + " turns!"
        let the_score = Score(score: victory_string)
        self.store.store(score: the_score)
        self.boss_move_log.text = victory_string
        self.hideButtons()
        self.boss_move_log.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    }
    
    @objc func updatePlayerDead(){
        self.player_move_log.text = "\(self.boss_name) has defeated player!"
        self.boss_move_log.text = "You Died! Better luck next time!"
        self.player_hp = model.player?.health ?? 0
        self.player_hp_label.text = String(self.player_hp)
        self.hideButtons()
        self.boss_move_log.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    }
    @objc func updateBossCharged(){
        self.charge_boss(bosstype: self.boss_type)
        self.boss_move_log.attributedText = create_text_with_color_in_center(part1: "\(self.boss_name) has ", part2: "charged up", part3: "!", a_color: UIColor.yellow)
    }
    
    @objc func updateBossUnCharge(){
        self.uncharge_boss(bosstype: self.boss_type)
    }
    
    @objc func updatePlayerPrepared(){
        let mult_level = self.model.multiplier
        self.player_move_log.attributedText = create_text_with_color_in_center(part1: "Player has prepared next action will do ", part2: "\(mult_level)x", part3: "!", a_color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
    }
    
    @objc func updatePlayerHealed(){
        self.player_hp = model.player?.health ?? 0
        self.player_hp_label.text = String(self.player_hp)
        let heal_amt = self.model.amount_restored
        self.player_move_log.attributedText = create_text_with_color_in_center(part1: "Player has restored  ", part2: "\(heal_amt) health", part3: "!", a_color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
    }
    @objc func updatePlayerDefended(){
        self.player_move_log.attributedText = create_text_with_color_in_center(part1: "Player has ", part2: "doubled their defense", part3: " this turn!", a_color: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
    }
    @objc func updateBossStunned(){
        self.boss_move_log.attributedText = create_text_with_color_in_center(part1: "Special attack ", part2: "stunned ", part3: "boss!", a_color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
    }
    
    func hideButtons(){
        self.button_one.isHidden = true
        self.button_two.isHidden = true
        self.button_three.isHidden = true
        self.play_again_button.isHidden = false
    }
    
    @objc func animate_boss_dmg(){
        let current_boss_image = self.boss_image.image
        UIView.transition(with: self.boss_image,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
                            if self.boss_type == 1{
                                self.boss_image.image = #imageLiteral(resourceName: "red_dragon")
                            }else if self.boss_type == 2{
                                self.boss_image.image = #imageLiteral(resourceName: "red_wolf")
                            }
                          }, completion: {done in
                            if done{
                                UIView.transition(with: self.boss_image,
                                                  duration: 0.25,
                                                  options: .transitionCrossDissolve,
                                                  animations: {
                                                    self.boss_image.image = current_boss_image
                                                  })
                            }
                          })
    }// end animate_boss_dmg
    
    @objc func animate_player_dmg(){
        let current_player_image = self.player_image.image
        UIView.transition(with: self.player_image,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {
                            if self.player_type == 1{
                                self.player_image.image = #imageLiteral(resourceName: "red_samurai")
                            }else if self.player_type == 2{
                                self.player_image.image = #imageLiteral(resourceName: "red_magic")
                            }
                          }, completion: {done in
                            if done{
                                UIView.transition(with: self.player_image,
                                                  duration: 0.25,
                                                  options: .transitionCrossDissolve,
                                                  animations: {
                                                    self.player_image.image = current_player_image
                                                  })
                            }
                          })
    }
    
    @objc func charge_boss(bosstype: Int){
        if bosstype == 1{
            UIView.transition(with: self.boss_image, duration: 0, options: .transitionCrossDissolve, animations: {
                self.boss_image.image = #imageLiteral(resourceName: "charged_dragon")
            })
        }else if bosstype == 2{
            UIView.transition(with: self.boss_image, duration: 0, options: .transitionCrossDissolve, animations: {
                self.boss_image.image = #imageLiteral(resourceName: "charged_wolf")
            })
        }
        
    }
    
    @objc func uncharge_boss(bosstype: Int){
        if bosstype == 1{
            UIView.transition(with: self.boss_image, duration: 0, options: .transitionCrossDissolve, animations: {
                self.boss_image.image = #imageLiteral(resourceName: "dragon")
            })
        }else if bosstype == 2{
            UIView.transition(with: self.boss_image, duration: 0, options: .transitionCrossDissolve, animations: {
                self.boss_image.image = #imageLiteral(resourceName: "wolf")
            })
        }
    }
    

    
}
