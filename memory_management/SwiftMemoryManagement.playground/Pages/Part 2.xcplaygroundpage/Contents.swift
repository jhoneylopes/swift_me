// Artigo: [Swift] Como evitar memory leak

import Foundation

class Master {
    var name: String
    private(set) var tables: [Table] = []
    private(set) var players: [Player] = []
    init(_ name: String) {
        self.name = name
        print("INIT Novo Mestre: \(self.name)")
    }
    
    deinit {
        print("DEINIT Mestre Saiu: \(self.name)")
    }
    
    func addTable(_ table: Table) {
        self.tables.append(table)
        table.master = self
    }
    
    func addPlayer(_ player: Player) {
        players.append(player)
    }
}

class Table {
    var system: String
    weak var master: Master?
    
    init(_ system: String) {
        self.system = system
        print("INIT Nova Mesa de: \(system)")
    }
    
    deinit {
        print("DEINIT Mesa de: \(system) Finalizada!")
    }
}

class Player {
    var name: String
    var table: Table
    unowned var master: Master
    
    init(_ name: String, _ table: Table, _ master: Master) {
        self.name = name
        self.table = table
        self.master = master
        master.addPlayer(self)
        print("INIT Player: \(name)")
    }
    
    deinit {
        print("DEINIT By \(name)")
    }
}

do {
    let tableOnline = Table("Sopro do Dragão")
    let theMaster = Master("Arthur")
    theMaster.addTable(tableOnline)
    
    let player1 = Player("Jhoney", tableOnline, theMaster)
    let player2 = Player("Mari", tableOnline, theMaster)
}

