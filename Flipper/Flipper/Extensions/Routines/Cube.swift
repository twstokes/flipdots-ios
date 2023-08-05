//
//  PerfectPong.swift
//  Flipper
//
//  Created by Tanner W. Stokes on 3/30/21.
//

import SwiftGFXWrapper

extension GFXMatrix {
    /// https://github.com/OpenHDZ/Arduino-experimentation/blob/master/cube_gfx.ino
    func cube() {
        let zOff: Float = -150
        let xOff: Float = 0
        let yOff: Float = 0
        let cSize: Float = 10
        let view_plane: Float = 64
        let angle = Float.pi/60

        var cube3d = [
          (xOff - cSize, yOff + cSize, zOff - cSize),
          (xOff + cSize, yOff + cSize, zOff - cSize),
          (xOff - cSize, yOff - cSize, zOff - cSize),
          (xOff + cSize, yOff - cSize, zOff - cSize),
          (xOff - cSize, yOff + cSize, zOff + cSize),
          (xOff + cSize, yOff + cSize, zOff + cSize),
          (xOff - cSize, yOff - cSize, zOff + cSize),
          (xOff + cSize, yOff - cSize, zOff + cSize)
        ]
        
        var cube2d = [
            (0, 0),
            (0, 0),
            (0, 0),
            (0, 0),
            (0, 0),
            (0, 0),
            (0, 0),
            (0, 0)
        ]
        
        
        setFrameBlock {
            xrotate(q: angle)
            zrotate(q: angle)
            yrotate(q: angle)
            printcube()
//            let rsteps = Int.random(in: 10...60)
//                switch(Int.random(in: 0..<6)) {
//                case 0:
//                for _ in 0..<rsteps {
//                    zrotate(q: angle)
//                    printcube()
//                }
//                case 1:
//                for _ in 0..<rsteps {
//                    zrotate(q: 2*Float.pi - angle)
//                    printcube()
//                }
//                case 2:
//                for _ in 0..<rsteps {
//                    xrotate(q: angle)
//                    printcube()
//                }
//                case 3:
//                for _ in 0..<rsteps {
//                    xrotate(q: 2*Float.pi - angle)
//                    printcube()
//                }
//                case 4:
//                for _ in 0..<rsteps {
//                    yrotate(q: angle)
//                    printcube()
//                }
//                case 5:
//                for _ in 0..<rsteps {
//                    yrotate(q: 2*Float.pi - angle)
//                    printcube()
//                }
//                default:
//                    break
//              }
        }
        
        func printcube() {
            for i in 0..<8 {
                cube2d[i].0 = Int((cube3d[i].0 * view_plane / cube3d[i].2) + (Float(width())/2))
                cube2d[i].1 = Int((cube3d[i].1 * view_plane / cube3d[i].2) + (Float(height())/2))
              }

            fillScreen(0)
            draw_cube()
        }

        func zrotate(q: Float) {
            var tx: Float
            var ty: Float
            var temp: Float
            
            for i in 0..<8 {
                tx = Float(cube3d[i].0 - xOff)
                ty = Float(cube3d[i].1 - yOff)
                temp = tx * cos(q) - ty * sin(q)
                ty = tx * sin(q) + ty * cos(q)
                tx = temp
                cube3d[i].0 = tx + xOff
                cube3d[i].1 = ty + yOff
            }
        }

        func yrotate(q: Float) {
            var tx: Float
            var tz: Float
            var temp: Float
            
            for i in 0..<8 {
                tx = Float(cube3d[i].0 - xOff)
                tz = Float(cube3d[i].2 - zOff)
                temp = tz * cos(q) - tx * sin(q)
                tx = tz * sin(q) + tx * cos(q)
                tz = temp
                cube3d[i].0 = tx + xOff
                cube3d[i].2 = tz + zOff
            }
        }

        func xrotate(q: Float) {
            var ty: Float
            var tz: Float
            var temp: Float
            
            for i in 0..<8 {
                ty = Float(cube3d[i].1 - yOff)
                tz = Float(cube3d[i].2 - zOff)
                temp = ty * cos(q) - tz * sin(q)
                tz = ty * sin(q) + tz * cos(q)
                ty = temp
                cube3d[i].1 = ty + yOff
                cube3d[i].2 = tz + zOff
            }
        }

        func draw_cube() {
            drawLine(cube2d[0].0, y0: cube2d[0].1, x1: cube2d[1].0, y1: cube2d[1].1, color: 1)
            drawLine(cube2d[0].0, y0: cube2d[0].1, x1: cube2d[2].0, y1: cube2d[2].1, color: 1)
            drawLine(cube2d[0].0, y0: cube2d[0].1, x1: cube2d[4].0, y1: cube2d[4].1, color: 1)
            drawLine(cube2d[1].0, y0: cube2d[1].1, x1: cube2d[5].0, y1: cube2d[5].1, color: 1)
            drawLine(cube2d[1].0, y0: cube2d[1].1, x1: cube2d[3].0, y1: cube2d[3].1, color: 1)
            drawLine(cube2d[2].0, y0: cube2d[2].1, x1: cube2d[6].0, y1: cube2d[6].1, color: 1)
            drawLine(cube2d[2].0, y0: cube2d[2].1, x1: cube2d[3].0, y1: cube2d[3].1, color: 1)
            drawLine(cube2d[4].0, y0: cube2d[4].1, x1: cube2d[6].0, y1: cube2d[6].1, color: 1)
            drawLine(cube2d[4].0, y0: cube2d[4].1, x1: cube2d[5].0, y1: cube2d[5].1, color: 1)
            drawLine(cube2d[7].0, y0: cube2d[7].1, x1: cube2d[6].0, y1: cube2d[6].1, color: 1)
            drawLine(cube2d[7].0, y0: cube2d[7].1, x1: cube2d[3].0, y1: cube2d[3].1, color: 1)
            drawLine(cube2d[7].0, y0: cube2d[7].1, x1: cube2d[5].0, y1: cube2d[5].1, color: 1)
        }
    }
}
