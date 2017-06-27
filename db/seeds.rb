# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
User.create!(name:  'Admin',
             email: 'admin@example.com',
             password:              'password',
             password_confirmation: 'password',
             admin: true)

Sheet.create!(name: 'Vampire: the Masquerade',
              properties: {
                generation: {
                  type: Integer
                },
                willpower: {
                  type: Integer
                },
                blood: {
                  type: Integer
                },
                physicals: {
                  constants: [
                    { name: 'One' },
                    { name: 'Two' },
                    { name: 'Three' },
                    { name: 'Four' },
                    { name: 'Five' } 
                  ],
                  default: []
                }
              })

Sheet.create!(name: 'Werewolf: the Apocalypse',
              properties: {
                essence: {
                  type: Integer
                },
                rage: {
                  type: Integer
                },
                gnosis: {
                  type: Integer
                },
                physicals: {
                  constants: [
                    { name: 'One' },
                    { name: 'Two' },
                    { name: 'Three' },
                    { name: 'Four' },
                    { name: 'Five' } 
                  ],
                  default: []
                }
              })