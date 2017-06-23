//: ## Resonant Filter Operation
//:
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0],
                           baseDir: .resources)

let player = try AKAudioPlayer(file: file)
player.looping = true

let effect = AKOperationEffect(player) { player, _ in
    let frequency = AKOperation.sineWave(frequency: 0.5).scale(minimum: 2_000, maximum: 5_000)
    let bandwidth = abs(AKOperation.sineWave(frequency: 0.3)) * 1_000

    return player.resonantFilter(frequency: frequency, bandwidth: bandwidth) * 0.1
}

AudioKit.output = effect
AudioKit.start()
player.play()

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
