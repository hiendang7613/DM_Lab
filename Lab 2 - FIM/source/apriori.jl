# import Pkg; 
# Pkg.add("Combinatorics")
using Combinatorics

# Mảng item
item_list = 1:4 
# Độ hỗ trợ nhỏ nhất minsup
minsup = 3 / 8

# Mảng giao tác
tran_arr = [[1, 2, 3, 4], [1, 2, 3], [1, 4], [2, 4], [1, 3], [2, 3], [1, 4]]

function apriori(tran_arr, minsup, item_list)
    # Chứa tất cả tập item có thể theo kích thước
    item_set_arr = [Set(collect(combinations(item_list, k))) for k = 1: length(item_list)]

    # Mảng tập phổ biến
    result = []

    # Tăng kích thước cho lần duyệt tập item
    for k = 1: length(item_list)
        print("\n=> Liệt kê tập item kích thước $k : $(item_set_arr[k])\n")

        # Duyệt tập item
        for item_set in item_set_arr[k]
            # Tính độ hỗ trợ của tập item này
            sup = sum([issubset(item_set, tran) for tran in tran_arr]) / length(tran_arr)

            # Loại tập item độ hỗ trợ nhỏ hơn minsup
            if sup < minsup
                print("$item_set có độ hỗ trợ nhỏ hơn minsup nên loại và bỏ tất cả tập item chứa nó\n")

                # bỏ tất cả tập item cha chứa tập item này
                for j = k + 1: length(item_list)
                    if length(item_set_arr[j]) == 0
                        break
                    end
                    filter!(x -> !issubset(item_set, x), item_set_arr[j])
                end
            else
                print( "$item_set có độ hỗ trợ lớn hơn minsup nên thêm vào tập phổ biến\n")
                push!(result, item_set)
            end
        end
    end
    return result
end

result = apriori(tran_arr, minsup, item_list)
@show result
