<?php

namespace App\Application\Middleware;

class ViewGlobalMiddleware
{
    protected $container;

    public function __construct($container)
    {
        $this->container = $container;
    }

    public function __invoke($request, $handler)
    {

        $db = $this->container->get('db');
        $footerArticles = $db->select('tbl_articles', ['id', 'title', 'slug', 'content'], [
            'status' => 1,
            'deleted_at' => null,
            'slug' => 'artikel-footer'
        ]);

        $socialMedia = $db->select('tbl_articles (a)', [
            '[><]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[><]tbl_categories (c)' => ['ac.id_category' => 'id']
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.image',
            'a.file',
            'a.status',
            'a.content',
            'a.created_at',
            'c.slug (category_slug)',
        ], [
            'a.status' => 1,
            'a.deleted_at' => null,
            'c.slug' => 'sosial-media'
        ]);

        $stories = $db->select('tbl_articles (a)', [
            '[>]tbl_users (u)' => ['a.id_user' => 'id'],
            '[>]tbl_articles_categories (ac)' => ['a.id' => 'id_article'],
            '[>]tbl_categories (c)' => ['ac.id_category' => 'id'],
        ], [
            'a.id',
            'a.title',
            'a.slug',
            'a.content',
            'a.status',
            'a.image',
            'a.file',
            'a.created_at',
            'u.name(user_name)',
        ], [
            'a.deleted_at' => null,
            'c.type' => 1,
            'a.status' => 1,
            'a.payment_at[!]' => null,
            'ORDER' => ['a.created_at' => 'DESC'],
            'GROUP' => 'a.id',
            'LIMIT' => 2
        ]);
        $i=0;
        foreach ($stories as $item) {
            $sc = $db->select('tbl_articles_categories (ac)', [
                '[>]tbl_categories (c)' => ['ac.id_category' => 'id']
            ], ['c.name'], ['ac.id_article' => $item['id']]);
            $stories[$i]['categories'] = array_column($sc, 'name');
            $bulan = [1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun', 7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des'];
            $tanggal = date('j', strtotime($item['created_at']));
            $bulanIndo = $bulan[(int)date('n', strtotime($item['created_at']))];
            $tahun = date('Y', strtotime($item['created_at']));
            $stories[$i]['created_at_formatted'] = "$tanggal $bulanIndo $tahun";
            $i++;
        }

        if ($this->container->has('view')) {
            $this->container->get('view')->getEnvironment()->addGlobal('footer_articles', $footerArticles);
            $this->container->get('view')->getEnvironment()->addGlobal('social_media', $socialMedia);
            $this->container->get('view')->getEnvironment()->addGlobal('lateststories', $stories);
        }

        return $handler->handle($request);
    }
}
