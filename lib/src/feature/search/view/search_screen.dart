import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:instagram_clone/src/feature/search/view_model/search_view_model_cubit.dart';
import 'package:instagram_clone/src/utils/app_colors.dart';
import 'package:instagram_clone/src/utils/app_text_style.dart';
import 'package:instagram_clone/src/widget/custom_text_form_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchViewModelCubit viewModel = SearchViewModelCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    viewModel.getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormFieldWidget(
                  label: '',
                  isLable: false,
                  controller: viewModel.searchController,
                  myValidator: (text) {},
                  hintText: 'Search...',
                  onChanged: (text) {
                    viewModel.search(text: text);
                  },
                ),
                BlocBuilder<SearchViewModelCubit, SearchViewModelState>(
                  bloc: viewModel..getAllPosts(),
                  builder: (context, state) {
                    if (state is SearchViewModelError) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    if (state is SearchViewModelSuccess) {
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: ListView.builder(
                              itemCount: viewModel.users.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20.r,
                                        backgroundImage: NetworkImage(
                                          viewModel.users[index].photoUrl,
                                        ),
                                      ),
                                      Gap(10.w),
                                      Text(
                                        viewModel.users[index].username,
                                        style:
                                            AppTextStyle.textStyle16.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is SearchViewModelLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is SearchViewModelGetAllPost) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: GridView.custom(
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 4,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            repeatPattern: QuiltedGridRepeatPattern.inverted,
                            pattern: [
                              const QuiltedGridTile(2, 2),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 1),
                              const QuiltedGridTile(1, 2),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                            (context, index) => Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.all(0),
                              child: Image.network(
                                viewModel.postsPosts[index].postImage,
                              ),
                            ),
                            childCount: viewModel.postsPosts.length,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
