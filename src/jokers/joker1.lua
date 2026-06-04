--SMODS.Joker{
    --key = 'joker1',
    --atlas = 'placeholders',
    --pos = {x=0, y=0},
    --config = {
       --extra = {
            --chips = 100
        --}
    --},
    --rarity = 1,
    --cost = 5,
    --loc_vars = function(self, info_queue, card)
            --return {
                --vars = {
                --card.ability.extra.chips
            --}
        --}
    --end,
    --calculate = function(self, card, context)
            --if context.joker_main then
                --return {
                    --chips = card.ability.extra.chips
                --}
            --end
    --end
--}

--JMC (art by Baconated_Coke)
SMODS.Joker{
    key = 'Propagule',
    unlocked = true,
    atlas = 'placeholders',
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    config = {extra = { copy = 1, odds = 8, mult = 5, chips = 22} },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'astravol_Propagule')
        return { vars = { numerator, denominator, card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.copy} }
     end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_Propagule', 1, card.ability.extra.odds) then
                local id = context.other_card:get_id()
                if id == 2 or id == 5 then
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local card_copied = copy_card(context.full_hand[1], nil, nil, G.playing_card)
                    card_copied:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, card_copied)
                    G.hand:emplace(card_copied)
                    card_copied.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_copied:start_materialize()
                            return true
                        end
                    }))
                end
            
        end

        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 2 then
                return{
                    chips = card.ability.extra.chips
                }
            elseif id == 5 then
                return{
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}



--Tac (art by Tac)
SMODS.Joker{
    key = 'Princess_of_the_Stars',
    unlocked = true,
    atlas = 'placeholders',
    pos = { x = 3, y = 0 },
    rarity = 1,
    cost = 5,
    config = {extra = {repetitions = 1, odds = 2, mult = 1, suit = 'Diamonds'}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'astravol_Princess_of_the_Stars')
        return { vars = { numerator, denominator, card.ability.extra.mult , localize(card.ability.extra.suit, 'suits_singular') } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_Princess_of_the_Stars', 1, card.ability.extra.odds) and context.other_card:is_suit(card.ability.extra.suit) then    
           return {
                    repetitions = card.ability.extra.repetitions,
                } 
    end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            return{
                mult = card.ability.extra.mult
            }
        end
    end,
    update = function(self, card, dt)
        if G.deck and card.added_to_deck then
			for i, v in pairs(G.deck.cards) do
				if v:get_id() == 12 then
                    v:set_debuff(true)
                end
            end
        end
        if G.hand and card.added_to_deck then
			for i, v in pairs(G.hand.cards) do
				if v:get_id() == 12 then
                    v:set_debuff(true)
                end
            end
        end
    end
}
--Orange (art by Tac)
SMODS.Joker {
    key = 'Orange',
    unlocked = true,
    atlas = 'placeholders',
    pos = { x = 2, y = 0},
    rarity = 2,
    cost = 6,
    calculate = function (self, card, context)
        if context.skip_blind then
            SMODS.add_card {
                set = 'Chariot', key = 'c_chariot', edition = 'e_negative',
            }
            SMODS.add_card {
                set = 'Chariot', key = 'c_chariot', edition = 'e_negative',
            }
        end
    end
}


--Zecah
SMODS.Joker {
    key = 'King_of_the_Stars',
    unlocked = true,
    atlas = 'placeholders',
    pos = {x = 0, y = 1},
    rarity = 1,
    cost = 5,
    config = {extra = {repetitions = 1, odds = 2, chips = 10, suit = 'Diamonds'}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'astravol_King_of_the_Stars')
        return { vars = { numerator, denominator, card.ability.extra.chips , localize(card.ability.extra.suit, 'suits_singular') } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_King_of_the_Stars', 1, card.ability.extra.odds) and context.other_card:is_suit(card.ability.extra.suit) then    
           return {
                    repetitions = card.ability.extra.repetitions,
                } 
    end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            return{
                chips = card.ability.extra.chips
            }
        end
    end,
}

--Xenas
SMODS.Joker {
    key = 'Queen_of_the_Stars',
    unlocked = true,
    atlas = 'placeholders',
    pos = {x = 4, y = 0},
    rarity = 2,
    cost = 7,
    config = { extra =  {repetitions = 1, replay_odds = 2, tarot_odds = 10, suit = 'Diamonds'} },
    loc_vars = function(self, info_queue, card)
        local replay_numerator, replay_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.replay_odds, 'astravol_Queen_of_the_Stars')
        local tarot_numerator, tarot_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.tarot_odds, 'astravol_Queen_of_the_Stars')
        return { vars = { replay_numerator, replay_denominator, tarot_numerator, tarot_denominator, localize(card.ability.extra.suit, 'suits_singular') } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_Queen_of_the_Stars', 1, card.ability.extra.replay_odds) and context.other_card:is_suit(card.ability.extra.suit) then    
           return {
                    repetitions = card.ability.extra.repetitions,
            } 
        end
        if context.individual and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_Queen_of_the_Stars', 1, card.ability.extra.tarot_odds) and context.other_card:is_suit(card.ability.extra.suit) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then    
            SMODS.add_card {
                set = 'Tarot'
            }
        end
    end

}

--Oldrummer
SMODS.Joker {
    key = 'King_of_Nothing',
    unlocked = true,
    atlas = 'placeholders',
    pos = {x = 0, y = 0},
    rarity = 3,
    cost = 9,
    config = { extra = { poker_hand = 'High Card' }},
    loc_vars = function (self, info_queue, card)
        return { vars = {localize(card.ability.extra.poker_hand, 'poker_hands')}}
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            return {
                level_up = true,
                message = localize('k_level_up_ex'),
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'astravol_King_of_Nothing')
            return {
                message = localize('k_reset')
            }
        end
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.blueprint and context.scoring_name == card.ability.extra.poker_hand then
            return {
                remove = true,
                delay = 0.45
            }
        end
    end
}
