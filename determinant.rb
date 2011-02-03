def det(matrix)
	if(matrix.length() == 1): return matrix[0][0] end
	result = 0
	matrix[0].each_with_index do |a,i|
		result += a*cofactor(0,i, matrix)
	end
	
	result
end

def minor(i,j, matrix)
	det(cross_remove(i,j,matrix))
end

def cross_remove(i,j,matrix)
	new = matrix.map { |r| Array.new(r) }
	new = new.map {|r| r.delete_at(j); r;}
	new.delete_at(i)
	new
end

def cofactor(i,j,matrix)
	((-1) ** (i+j)) * minor(i,j,matrix)
end
