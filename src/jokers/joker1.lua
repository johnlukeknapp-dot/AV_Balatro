SMODS.Joker{
    key = 'joker1',
    atlas = 'placeholders',
    pos = {
        x=0,
        y=0
    },
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
    rarity = 1,
    cost = 4,
    config = {extra = { repetitions = 1, odds = 2} },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'astravol_Propagule')
        return { vars = { numerator, denominator } }
     end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.pseudorandom_probability(card, 'astravol_Propagule', 1, card.ability.extra.odds) then
            local id = context.other_card:get_id()
            if id == 2 or id == 5 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}
