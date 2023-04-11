import itertools
import re


def paid_per_line(line):
    return re.findall(',R(\d+)', line) + re.findall('-R(\d+)', line)


class Till:
    till_denomination = [50, 50, 50, 50, 50, 20, 20, 20, 20, 20, 10, 10, 10, 10, 10, 10,
                         5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
                         1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

    def __init__(self, lines):
        self.lines = lines

    def cost_per_line(self, line):
        return re.findall('R(\d+);', line) + re.findall('R(\d+),', line)

    def breakdown_change(self, target_sum):
        found = False
        my_breakdown = ()

        for r in range(1, len(self.till_denomination) + 1):
            if found:
                break
            for combination in itertools.combinations(self.till_denomination, r):
                if sum(combination) == target_sum:
                    # print(f"{'+'.join(map(str, combination))} = {target_sum}")
                    my_breakdown = combination
                    found = True
                    break

        if not found:
            pass
        return my_breakdown

    def process(self):
        change_total = 0
        total_till_money = 500

        for line in self.lines:
            cost_line = self.cost_per_line(line)
            paid_line = paid_per_line(line)

            paid_total = 0
            for paid in paid_line:
                paid_total += int(paid)
                self.till_denomination.append(int(paid))

            cost_total = 0
            for cost in cost_line:
                cost_total += int(cost)
                total_till_money += int(cost)

            change_total = paid_total - cost_total

            list_breakdown = ()
            breakdown = ''
            if change_total == 0:
                list_breakdown = (0, 0)
            else:
                for change_to_remove in self.breakdown_change(change_total):
                    self.till_denomination.remove(int(change_to_remove))

                list_breakdown = self.breakdown_change(change_total)

            for change in list_breakdown:
                breakdown += '-R' + str(change)

            print(f'R{total_till_money:<20}R{cost_total:<20}R{paid_total:<20}R{change_total:<20}{breakdown[1:]}')
        print(f'\nTotal Money left in till: R{total_till_money}')
