SMODS.Joker{
    key = 'joker1',
    atlas = 'placeholders',
    pos = {x=0, y=0},
    config = {
        extra = {
            chips = 100
        }
    },
    rarity = 1,
    cost = 5,
    loc_vars = function(self, info_queue, card)
            return {
                vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            end
    end
}

--JMC
SMODS.Joker{
    key = 'Propagule',
    atlas = 'placeholders',
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    config = {extra = { repetitions = 1, odds = 2, mult = 5, chips = 22} },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'astravol_Propagule')
        return { vars = { numerator, denominator, card.ability.extra.mult, card.ability.extra.chips} }
     end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_Propagule', 1, card.ability.extra.odds) then
            local id = context.other_card:get_id()
            if id == 2 or id == 5 then
                return {
                    repetitions = card.ability.extra.repetitions,
                }
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


--Tac
SMODS.Joker{
    key = 'Princess_of_the_Stars',
    atlas = 'placeholders',
    pos = { x = 3, y = 0 },
    rarity = 1,
    cost = 5,
    config = {extra = {repetitions = 1, odds = 2, mult = 2, suit = 'Diamonds'}},
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
                --local id = context.other_card:get_id()
				if v:get_id() == 12 then
                    v:set_debuff(true)
                end
            end
        end
        if G.hand and card.added_to_deck then
			for i, v in pairs(G.hand.cards) do
                --local id = context.other_card:get_id()
				if v:get_id() == 12 then
                    v:set_debuff(true)
                end
            end
        end
    end
}
